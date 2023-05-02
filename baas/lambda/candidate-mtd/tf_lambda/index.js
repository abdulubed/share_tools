exports.lambdaHandler = async (event, context) => {
    const sqlc = require('./sqlconnect');
    const MTDFunctions = require('./mtdfunctions');
    const SecretsManager = require('./keystore');
    var keyStore=new SecretsManager;
    var sqlConnect = new sqlc;
    var mtdfunc = new MTDFunctions;
    var config = {};
    var control_action = new Map([
        ['sum', 'mtdfunc.mtdsum'],
        ['count', 'mtdfunc.mtdcount'],
        ['avg', 'mtdfunc.mtdavg']
    ]);
    let body = JSON.parse(event.body)
    console.log(body)

    var data = body["data"];

    var data_parsed, key, newdata, control_action_dr = '';
    var result = "MATCHED";
    var responsearry = [];
    for (var obj in data) {
        data_parsed = JSON.parse(data[obj][1])

        key = Object.keys(data_parsed);

        try {
            var awsAccountId = context.invokedFunctionArn.split(':')[4];
            var region = process.env.REGION;
            var secretName = 'arn:aws:secretsmanager:' + region +':' + awsAccountId + ':secret:'+data_parsed[key].AWS_DB_ARN_SECRET;
            var keyValue = JSON.parse(await keyStore.getSecret(secretName, region));

            if (keyValue==undefined){throw "Could not fetch database Information: Check if AWS database secret has appropriate access"}

            config = { user: keyValue.username, password: keyValue.password, server: keyValue.host, database: data_parsed[key].DATABASE_NAME, port: Number(keyValue.port), trustServerCertificate: true, requestTimeout: 300000 };
            
            await sqlConnect.connectdb(config);
            var proc_query = await mtdfunc.processproc(data_parsed[key].PROC_QUERY, data_parsed[key].LAST_EXTRACT_DT);
            console.log("Processing :" + data_parsed[key].PROPERTY);
            var newdata = await sqlConnect.getdata(proc_query);
            var i = 0;
            while (i < data_parsed[key].TOTALS.length) {
                control_action_dr = control_action.get(data_parsed[key].TOTALS[i].action.toLowerCase())
                console.log(control_action_dr)
                console.log("(newdata,'" + data_parsed[key].TOTALS[i].column + "'")
                console.log(control_action_dr + "(newdata,'" + data_parsed[key].TOTALS[i].column + "')")
                extval = await eval(control_action_dr + "(newdata,'" + data_parsed[key].TOTALS[i].column + "')")
                if (extval == data_parsed[key].TOTALS[i].value) {

                    console.log("PASS SNOW " + data_parsed[key].TOTALS[i].column + ":" + data_parsed[key].TOTALS[i].action + " SNOW :" + extval)
                }
                else {
                    result = "NOT MATCHED"

                    console.log("FAIL SNOW " + data_parsed[key].TOTALS[i].column + ":" + data_parsed[key].TOTALS[i].action + " SNOW :" + extval)
                }
                i++;
            }

            responsearry.push([Number(obj), result])
        }
        catch (err) {
            console.log(err)
            responsearry.push([Number(obj), "FAILURE : " + err])
            continue

        }
    }

    responsearry = JSON.stringify(responsearry)
    const response = {
        "statusCode": 200,
        "headers": {
            "my_header": "my_value"
        },
        "body": "{'data': " + responsearry + " }",
        //     "body": "{\"data\": [ [ 0, \"page\" ], [ 1, \"life, the universe, and everything\" ] ] }",
        "isBase64Encoded": false
    };

    return await response;
};
