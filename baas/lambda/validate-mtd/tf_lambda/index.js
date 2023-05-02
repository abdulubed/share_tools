var AWS = require('aws-sdk');
AWS.config.region = process.env.REGION;
const s3 = new AWS.S3({ apiVersion: '2006-03-01' });
const { format, addHours, subtract } = require('date-and-time');
const sqlc = require('./sqlconnect');
const MTDFunctions = require('./mtdfunctions');
const SecretsManager = require('./keystore');
var keyStore = new SecretsManager;

var lambda = new AWS.Lambda();
var mtdfunc = new MTDFunctions;
var sqlConnect = new sqlc;

var HTTP_METHOD_STRING = "httpMethod";
var CURRENT_LAMBDA_NAME = "";
var DATA_ELEMENT_NAME = "data";
var SNOWFLAKE_DATABASE = process.env.SNOWFLAKE_DATABASE;

exports.lambdaHandler = function(event, context) {

    CURRENT_LAMBDA_NAME = context.functionName;

    if (HTTP_METHOD_STRING in event) {
        var method = event[HTTP_METHOD_STRING];
        if (method == "POST") {
            return initiate(event, context);
        }
        else {
            return create_response(400, "Function called from invalid method");
        }
    }
    else {
        return asyncinitiate(event, context); /// main async process
    }

    function create_response(code, msg) {
        return {
            "statusCode": code,

            "body": "{'data': [ [ 0,'" + msg + "']]  }",

            "isBase64Encoded": false
        };
    }

    function initiate(event, context) {
        let body = JSON.parse(event.body);
        var data = body[DATA_ELEMENT_NAME][0];
        var lambda_response = [];
        lambda_response = invoke_process_lambda(data);
        //     lambda response returns 202, because we are invoking it with
        //    InvocationType = 'Event'
        if (lambda_response["StatusCode"] != 202) {
            var response = create_response(400, 'Fail');
        }
        else {
            response = {
                'statusCode': lambda_response["StatusCode"]
            };
        }
        return response;
    }

    function invoke_process_lambda(data, ) {
        // Create payload to be sent to processing lambda
        var invoke_payload = {
            FunctionName: CURRENT_LAMBDA_NAME,
            InvocationType: 'Event',
            LogType: 'Tail',
            Payload: JSON.stringify(data)
        };

        // Invoke processing lambda asynchronously by using InvocationType='Event'.
        // This allows the processing to continue while the POST handler returns HTTP 202.
        var lambda_response = lambda.invoke(invoke_payload, function(err, datapost) {
            if (err) {
                context.fail(create_response(400, "FAILURE : Process Start Failed"));
            }
            else {
                context.succeed(create_response(200, "SUCCESS : Process Started"));
            }
        });
        return lambda_response;
    }

    async function asyncinitiate(event, context) {
        var awsAccountId = context.invokedFunctionArn.split(':')[4];
        var data_parsed, key, unique_columns, validate_columns = '';
        var responsearry = [];

        data_parsed = event[1]; // get data from event
        console.log(data_parsed)
        //clean data in data
        data_parsed = JSON.parse(data_parsed.replace('"DETAILDATA":["', '"DETAILDATA":[').replace('"}]}"]}}', '"}]}]}}').replace('[0,"{', '[0,{').replace(']}}"]', ']}}]'));
        console.log(data_parsed)

        for (var obj in data_parsed) {
            key = Object.keys(data_parsed);
            try {

                //format start and end date
                var lastdate = new Date(data_parsed[key].LAST_EXTRACT_DT);
                var enddt = new Date(format(lastdate, 'YYYY-MM-DD'));
                var startdt = new Date(format(lastdate, 'YYYY-MM-01'));
                var chekmatch = [];
                var lowdata = 0;

                //fetch detail data node
                var detaildata = data_parsed[key].DETAILDATA[0];

                // fecth validation and select columns
                unique_columns = detaildata.COLUMNS[0].UNIQUECOLUMNS.split(',');
                validate_columns = detaildata.COLUMNS[1].VALUECOLUMNS.split(',');


                console.log("Processing :" + data_parsed[key].PROPERTY);
                var deepdate = addHours(startdt, -24);

                var loopdate = subtract(enddt, startdt).toDays(); // get date to loop

                var sqlconfig = await sqlConnect.getDatabaseConfig(data_parsed, key, awsAccountId);


                for (var loopd = 0; loopd < loopdate; loopd++) {
                    deepdate = addHours(deepdate, 24);

                    //get source procedure/query and subsitute appropriate start and end date within the query
                    var proc_query = await mtdfunc.processproc(data_parsed[key].PROC_QUERY, deepdate.toISOString());
                    //connect to Source SQL
                    await sqlConnect.getDatabaseConnection(data_parsed, key, sqlconfig)
                        //await sqlConnect.connectdb(config)
                        .then(async function(connection) {
                            // execute the store procedure and get source data
                            await sqlConnect.getdata(proc_query)
                                .then(async function(sourcedata) {
                                    //loop through results
                                    for (var i = 0; i < sourcedata.recordset.length; i++) {
                                        //call function to validate detail data row by row
                                        var root_batch_id=data_parsed[key]["BATCH"]["BATCH_ID"];
                                        mtdfunc.validateSnowflaketoSource(detaildata.DATA, sourcedata.recordset[i], unique_columns, validate_columns,deepdate.toISOString(),root_batch_id)
                                            .then(async errrows => {
                                                if (errrows.length > 0) {
                                                    //Store mismatches in json variable
                                                    chekmatch.push(errrows);
                                                }
                                            })
                                            .catch(err => {
                                                console.log(err)
  //                                              sqlConnect.insertError(data_parsed, key, err.message, SNOWFLAKE_DATABASE)
//                                                process.exit(1)
                                            })
                                    }
                                    sqlConnect.sqlclose();
                                });
                        });

                }
                responsearry.push([0, chekmatch]);
                //update log in snowflake
            }
            catch (err) {
                console.log(err);
                responsearry.push([0, chekmatch]);
                console.log(err.message)
                await sqlConnect.insertError(data_parsed, key, err.message, SNOWFLAKE_DATABASE, awsAccountId)
                continue;
            }

            await sqlConnect.connectToSnowflake(awsAccountId)
                .then(async cons => {
                    var useQuery = 'USE DATABASE ' + SNOWFLAKE_DATABASE;
                    await sqlConnect.executeSnow(cons, useQuery)
                        .then(async usedatabse => {
                            await sqlConnect.insertSnowLog(cons, data_parsed, key, chekmatch, 'COMPLETE')
                            await sqlConnect.insertFactRow(cons, data_parsed, key, chekmatch,validate_columns,)

                        });
                });
        }

        responsearry = JSON.stringify(responsearry);
        const response = {
            "statusCode": 200,
            "headers": {
                "my_header": "my_value"
            },
            "body": "{'data': " + responsearry + "  }",
            //     "body": "{\"data\": [ [ 0, \"page\" ], [ 1, \"life, the universe, and everything\" ] ] }",
            "isBase64Encoded": false
        };
        return response;
    }
};
