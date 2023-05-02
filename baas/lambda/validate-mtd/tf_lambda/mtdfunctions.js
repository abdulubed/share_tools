const { format } = require('date-and-time');
var groupBy = require('json-groupby');

class MTDFunctions {
  async processproc(varprocquery, extstart) {
    return new Promise(async (resolve, reject) => {
      try {
        var extend = new Date(extstart);
        extend.setDate(extend.getDate() + 1);
        var extstartformated = format(new Date(extstart), 'YYYY-MM-DD');
        var extendformated = format(new Date(extend), 'YYYY-MM-DD');
        var sql_query = varprocquery.replace(/~/g, "'");
        sql_query = sql_query.replace('$extract_start_dt_tmstamp', "'" + extstartformated + "'");
        sql_query = sql_query.replace('$extract_end_dt_tmstamp', "'" + extendformated + "'");
        resolve(sql_query);
      }
      catch (err) {
        reject('FAILED:' + err.message);
      }
    });
  }

  async mtdsum(recorddata, recordcolumn) {
    try {
      recorddata = JSON.parse(JSON.stringify(recorddata).toUpperCase());
      var total = recorddata.RECORDSET.reduce(function(sum, rec) {
        return sum + eval('rec.' + recordcolumn.toUpperCase());
      }, 0);
      return total;
    }
    catch (err) { return 'FAILED:' + err.message }
  }

  async mtdavg(recorddata, recordcolumn) {
    try {
      var total = 0;
      var i = 0;
      recorddata = JSON.parse(JSON.stringify(recorddata).toUpperCase());
      var reccolumn = recordcolumn.toUpperCase();
      for (i = 0; i < recorddata.RECORDSET.length; i++) {
        total += eval('recorddata.RECORDSET[' + i + '].' + reccolumn);
      }
      return total / recorddata.RECORDSET.length;
    }
    catch (err) {
      return 'FAILED:' + err.message;
    }
  }

  async mtdcount(recorddata, recordcolumn) {
    try {
      return recorddata.recordset.length;
    }
    catch (err) {
      return 'FAILED:' + err.message;

    }
  }

  getParameterCaseInsensitiveValue(object, key) {
    return object[Object.keys(object)
      .find(k => k.toLowerCase() === key.toLowerCase())
    ];
  }

  getParameterCaseInsensitiveKey(object, key) {
    return Object.keys(object)
      .find(k => k.toLowerCase() === key.toLowerCase());
  }

  retriveJsonRowData(object, groupbyclause) {
    var groupvar = [];
    groupbyclause.forEach((x, i) =>
      groupvar.push(this.getParameterCaseInsensitiveKey(object[0], x))
    );
    return groupBy(object, groupvar);
  }

  retriveSourceRow(object, groupbyclause) {
    var groupvar = {};
    groupbyclause.forEach((x, i) =>
      groupvar[(this.getParameterCaseInsensitiveKey(object, x))] = this.getParameterCaseInsensitiveValue(object, x)
    );
    return groupvar;
  }

  async validateSnowflaketoSource(snowflakedata, sourcedata, groupbyclause, columnvalue, extstart, root_batch_id) {
    return new Promise(async (resolve, reject) => {
      try {

        var extend = new Date(extstart);
        extend.setDate(extend.getDate() + 1);
        var extstartformated = format(new Date(extstart), 'YYYY-MM-DD 3:00');
        var extendformated = format(new Date(extend), 'YYYY-MM-DD 2:59');
        var psnowflakedata = this.retriveJsonRowData(snowflakedata, groupbyclause);
        var rootelement = psnowflakedata;
        var filtercolumns = '';
        var unmatched = [];
        var missingrow = false;

        for (var groupcolumn in groupbyclause) {
          try {
            var sourcegroupvalue = (this.getParameterCaseInsensitiveValue(sourcedata, groupbyclause[groupcolumn])).toString();

            rootelement = this.getParameterCaseInsensitiveValue(rootelement, sourcegroupvalue);
            if (rootelement == undefined) { throw "missingrow" }

            filtercolumns = sourcegroupvalue != '' || undefined ? filtercolumns + '"' + groupbyclause[groupcolumn] + '":"' + sourcegroupvalue + '",' : '';
            missingrow = false;


          }
          catch (err) {
            missingrow = true;
            console.log(snowflakedata)

            raw_batch_id = snowflakedata.find(item => format(new Date(item.EXTRACT_START_DATE), 'YYYY-MM-DD 3:00') === extstartformated)["RAW_TABLE_BATCH_ID"]
            unmatched.push({ "Error": { "ErrorType": "row", "SourceHandle": this.retriveSourceRow(sourcedata, groupbyclause) }, sourcedata, "BatchId": raw_batch_id, "extStartDate": extstartformated, "extEndDate": extendformated });

            break;
          }
        }


        if (!missingrow) {
          filtercolumns = filtercolumns.substring(0, filtercolumns.length - 1);
          var sourcevalue, snowflakevalue, raw_batch_id;
          raw_batch_id = (rootelement[0]["RAW_TABLE_BATCH_ID"]).toString();

          for (var valuecolumn in columnvalue) {
            sourcevalue = (this.getParameterCaseInsensitiveValue(sourcedata, columnvalue[valuecolumn])).toString();
            snowflakevalue = (rootelement[0][columnvalue[valuecolumn]]).toString();

            if (sourcevalue == snowflakevalue) {}
            else {
              var mismatch = { "Column": columnvalue[valuecolumn], "Source": sourcevalue, "Local": snowflakevalue };
              unmatched.push({ "Error": { "ErrorType": "value", "Mismatch": mismatch, "SourceHandle": this.retriveSourceRow(sourcedata, groupbyclause) }, sourcedata, "BatchId": raw_batch_id, "extStartDate": extstartformated, "extEndDate": extendformated });
            }
          }
        }

        console.log(unmatched)
        resolve(unmatched);
      }
      catch (err) {
        reject('FAILED:' + err.message);

      }
    });
  }
}
module.exports = MTDFunctions;
