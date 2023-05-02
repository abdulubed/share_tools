const { format, transform, parse } = require('date-and-time');

class MTDFunctions {

  async processproc(varprocquery, extdate) {
    return new Promise(async (resolve, reject) => {
      try {
        var extract_end_date = format(new Date(extdate), 'MM-DD-YYYY');
        var extract_start_date = transform(extract_end_date, 'MM-DD-YYYY', 'MM-1-YYYY');
        var sql_query = varprocquery.replace(/~/g, "'")
        sql_query = sql_query.replace('$extract_start_dt_tmstamp', "'" + extract_start_date + "'")
        sql_query = sql_query.replace('$extract_end_dt_tmstamp', "'" + extract_end_date + "'")
        resolve(sql_query)
      }
      catch (err) {
        reject('FAILED:' + err.message)

      }
    })
  }

  async mtdsum(recorddata, recordcolumn) {
    try {
      //recorddata =recorddata.recordset// JSON.parse(JSON.stringify(recorddata).toUpperCase());
      console.log("outsum")
      var total = recorddata.recordset.reduce(function(sum, rec) {
    //    return sum + eval('rec.' + recordcolumn.toUpperCase());
    var nm_value= rec[Object.keys(rec).find(k => k.toLowerCase() === recordcolumn.toLowerCase())];
    return sum + nm_value;
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
      var reccolumn = recordcolumn.toUpperCase()

      for (i = 0; i < recorddata.RECORDSET.length; i++) {
        total += eval('recorddata.RECORDSET[' + i + '].' + reccolumn);
      }
      return total / recorddata.RECORDSET.length;
    }
    catch (err) {
      return 'FAILED:' + err.message

    }
  }

  async mtdcount(recorddata, recordcolumn) {
    try {
      return recorddata.recordset.length;
    }
    catch (err) {
      return 'FAILED:' + err.message
    }
  }
}
module.exports = MTDFunctions;