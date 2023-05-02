const sql = require('mssql');
const snowflake = require('snowflake-sdk');
const { format } = require('date-and-time');
const SecretsManager = require('./keystore');
var keyStore = new SecretsManager;
var SNOWFLAKE_KEY_STORE_ARN_SECRET = process.env.SNOWFLAKE_KEY_STORE_ARN_SECRET;

let connection = null;

class Database {

  async getDatabaseConnection(data, key, sqlconfig) {
    return new Promise(async (resolve, reject) => {
      if (connection) {
        resolve(connection);
      }
      else {
        // var config = await this.getDatabaseConfig(data, key);
        await sql.connect(sqlconfig)
          .then(() => {
              resolve(connection);
            },
            (error) => {
              console.error(`Connecting error: ${error}`);
              reject(error);
            });

      }
    });
  }

  async getDatabaseConfig(data, key, awsAccountId) {
    
    var region = process.env.REGION;
    var secretName = 'arn:aws:secretsmanager:' + region + ':' + awsAccountId + ':secret:' + data[key].AWS_DB_ARN_SECRET;

    try {
      var keyValue = JSON.parse(await keyStore.getSecret(secretName, region));
    }
    catch (err) {
      console.log('Could not fetch database Information: Check if AWS database secret has appropriate access');
      throw "Could not fetch database Information: Check if AWS database secret has appropriate access";
    }

    if (keyValue == undefined) { throw "Could not fetch database Information: Check if AWS database secret has appropriate access" }
    return { user: keyValue.username, password: keyValue.password, server: (keyValue.host).toString(), database: data[key].DATABASE_NAME, port: Number(keyValue.port), trustServerCertificate: true, requestTimeout: 300000 };
  }

  async getdata(sqlquery) {
    return new Promise(async (resolve, reject) => {
      try {
        var request = new sql.Request();
        request.query(sqlquery)
          .then(data => {
            resolve(data);
          });
      }
      catch (err) {
        reject(err);
      }
    });
  }

  async sqlclose() {
    return sql.close();
  }

  async connectToSnowflake(awsAccountId) {
    var region = process.env.REGION;
    var secretName = 'arn:aws:secretsmanager:' + region + ':' + awsAccountId + ':secret:' + SNOWFLAKE_KEY_STORE_ARN_SECRET;

    try {
      var snowKeyValue = JSON.parse(await keyStore.getSecret(secretName, region));
    }
    catch (err) {
      console.log('Could not fetch Snowflake database Information: Check if AWS database secret has appropriate access');
      throw "Could not fetch Snowflake database Information: Check if AWS database secret has appropriate access";
    }
    if (snowKeyValue == undefined) { throw "Could not fetch Snowflake database Information: Check if AWS database secret has appropriate access" }

    var connectionsnow = snowflake.createConnection({
      username: snowKeyValue.username,
      password: snowKeyValue.password,
      account: snowKeyValue.account,
      warehouse: snowKeyValue.warehouse,
      database: snowKeyValue.database,
      schema: snowKeyValue.schema,
      role: snowKeyValue.role
    });

    return new Promise(async (resolve, reject) => {
      try {
        await connectionsnow.connect(
          function(err, conn) {
            if (err) {
              console.error('Unable to connect: ' + err.message);
              reject(err);
            }
            else {
              console.log('Successfully connected to Snowflake.');
              resolve(conn);
            }
          });

      }
      catch (err) {
        reject(err);
      }
    });
  }

  async executeSnow(connection, sqlQuery, bindsd) {
    return new Promise(async (resolve, reject) => {
      try {
        connection.execute({
          sqlText: sqlQuery,
          binds: bindsd,
          complete: function(err, stmt, rows) {
            if (err) {
              console.error('Failed to execute statement due to the following error: ' + err.message);
              reject(err);
            }
            else {
              console.log('Successfully executed query');
              resolve(rows);
            }
          }
        });
      }

      catch (err) {
        reject(err);
      }
    });
  }


  async insertSnowLog(connection, data, key, checkmatch, status) {

    return new Promise(async (resolve, reject) => {
      try {
        var lighterlog = [];
        if (status == "COMPLETE") {

          for (var obj in checkmatch) {
            lighterlog.push(checkmatch[obj][0]["Error"]);
          }
        }

        var insert_log_query = "insert into " +
          "DAAS_COMMON_SOX.CDC_MTD_RUN_LOG (SOURCE_SYSTEM_NAME,LAST_RUN_DTM,PROPERTY_CODE,RUN_TYPE,RUN_STATUS,FAIL_REASON," +
          "LAST_CDC_CONTROL_DTM,JOB_ID,SHARD_NAME,BATCH_ID,DATA_TYPE) values ('" +
          data[key].SOURCE_SYSTEM_NAME + "'," +
          "CURRENT_TIMESTAMP,'" +
          data[key].PROPERTY + "','" +
          "DEEPVALIDATE','" +
          status + "','" +
          JSON.stringify(lighterlog) + "','" +
          format(new Date(data[key].LAST_EXTRACT_DT), 'YYYY-MM-DD hh:mm') + "','" +
          data[key]['BATCH'].JOB_ID + "','" +
          data[key]['BATCH'].SHARD_NAME + "','" +
          data[key]['BATCH'].BATCH_ID + "','" +
          data[key].DATA_TYPE +
          "')";

        var insertlog = await this.executeSnow(connection, insert_log_query)
        resolve(insertlog);

      }

      catch (err) {
        reject(err);
      }
    })
  }

  async insertFactRow(connection, data, key, chekmatch, validate_columns) {

    return new Promise(async (resolve, reject) => {

      try {
        // var objectkey = await this.formCompleteColumns(chekmatch[0][0]["sourcedata"])
        var insertbinds = [];
        var objectkey = ((Object.keys(chekmatch[0][0]["sourcedata"])).toString()).replace(/,,/g, `,`) + ",RAW_TABLE_BATCH_ID,EXTRACT_START_DATE,EXTRACT_END_DATE,ROW_ID";
        var valid_column_array = objectkey.split(',');
        var insertstatementval;
        var nextvalstatement = "select " + data[key]["SCHEMA_NAME"] + "." + data[key]["FACT_SEQUENCE_NAME"] + ".nextval"

        var nextval = await this.executeSnow(connection, nextvalstatement)
        var loopval = nextval[0].NEXTVAL

        for (var chk in chekmatch) {

          validate_columns = validate_columns.map(function(x) { return x.toUpperCase(); });
          var insertvalues = [];

          var error_type = chekmatch[chk][0]["Error"]["ErrorType"];
          for (var vca in valid_column_array) {
            var diffvalue = '';
            if (error_type == "value") {
              var error_column = (chekmatch[chk][0]["Error"]["Mismatch"]["Column"]).toUpperCase();
              if (error_column == (valid_column_array[vca]).toUpperCase()) {
                var source_value = chekmatch[chk][0]["Error"]["Mismatch"]["Source"];
                var local_value = chekmatch[chk][0]["Error"]["Mismatch"]["Local"];
                diffvalue = source_value - local_value;
              }
              else {
                if (validate_columns.includes((valid_column_array[vca]).toUpperCase())) {
                  diffvalue = 0;
                }
                else {

                  switch (valid_column_array[vca]) {
                    case "RAW_TABLE_BATCH_ID":
                      diffvalue = Number(chekmatch[chk][0]["BatchId"]);
                      break;
                    case "EXTRACT_START_DATE":
                      diffvalue = chekmatch[chk][0]["extStartDate"];
                      break;
                    case "EXTRACT_END_DATE":
                      diffvalue = chekmatch[chk][0]["extEndDate"];
                      break;
                    case "ROW_ID":
                      diffvalue = loopval++;
                      break;
                    default:
                      diffvalue = chekmatch[chk][0]["sourcedata"][valid_column_array[vca]];
                  }

                }
              }
              insertvalues.push(diffvalue);
            }
            else {


              switch (valid_column_array[vca]) {
                case "RAW_TABLE_BATCH_ID":
                  insertvalues.push(Number(chekmatch[chk][0]["BatchId"]));
                  break;
                case "EXTRACT_START_DATE":
                  insertvalues.push(chekmatch[chk][0]["extStartDate"]);
                  break;
                case "EXTRACT_END_DATE":
                  insertvalues.push(chekmatch[chk][0]["extEndDate"]);
                  break;
                case "ROW_ID":
                  insertvalues.push(loopval++);
                  break;
                default:
                  insertvalues.push(chekmatch[chk][0]["sourcedata"][valid_column_array[vca]]);
              }

            }
          }

          insertvalues = await this.formCompletedata(data, key, insertvalues);
          insertbinds.push(insertvalues);
        }

        //insertstatement = insertstatement.substr(0, insertstatement.length - 1) + ')'
        var objectkey = await this.formCompleteColumns(objectkey)
        var insertstatement = 'INSERT INTO ' + data[key].SCHEMA_NAME + '.' + data[key].FACT_TABLE_NAME + '(' + objectkey + ') values (';
        insertstatementval = ('?,').repeat((Object.keys(valid_column_array)).length);
        insertstatementval = insertstatementval + '?,?,?,?,?,?)' // seven fixed datapoints
        insertstatement = insertstatement + insertstatementval
        console.log(insertstatement)
        console.log(insertbinds)
        await this.executeSnow(connection, insertstatement, insertbinds);
        resolve(chekmatch);
      }

      catch (err) {
        reject(err);
      }
    });
  }

  async insertError(data, key, message, SNOWFLAKE_DATABASE, awsAccountId) {


    return new Promise(async (resolve, reject) => {
      try {
        await this.connectToSnowflake(awsAccountId)
          .then(async cons => {
            var useQuery = 'USE DATABASE ' + SNOWFLAKE_DATABASE;
            await this.executeSnow(cons, useQuery)
              .then(async usedatabse => {
                await this.insertSnowLog(cons, data, key, message, 'FAILURE')
              });
          });
      }
      catch (err) {
        console.log(err)
        reject(err);
      }

    })
  }

  async formCompleteColumns(objectkey) {

    return new Promise(async (resolve, reject) => {
      try {

        objectkey = objectkey + ",PROPERTY_CODE,SOURCE_SYSTEM_NM,TIME_ZONE,CREATED_DTTM,CREATED_BY,RAW_TABLE_NAME"
        resolve(objectkey)
      }
      catch (err) {
        console.log(err)
        reject(err);
      }

    })

  }

  async formCompletedata(data, key, insertvalues) {

    return new Promise(async (resolve, reject) => {
      try {

        insertvalues.push(data[key]["PROPERTY"])
        insertvalues.push(data[key]["SOURCE_SYSTEM_NAME"])
        insertvalues.push("PST")
        insertvalues.push(new Date())
        insertvalues.push("LAMBDA_MTD")
        insertvalues.push("")
        //  var test= 'DAAS_CORE_SOX.CVPS_CASHIER_SUMMARY_REPORT_DISCOUNTS_FACT_SEQ.nextval'
        // insertvalues.push(test)//.replace(/'/g,''))
        resolve(insertvalues)
      }
      catch (err) {
        console.log(err)
        reject(err);
      }

    })

  }
}
module.exports = Database;