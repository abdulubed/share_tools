const sql = require('mssql');

class Database {
  async connectdb(sqlconfig,sqlquery) {

    return new Promise(async(resolve, reject) => {
          try{
            var  connected=await sql.connect(sqlconfig)
            if (connected){resolve(true)}
            else{ reject('FAILED: unable to connect '+sqlconfig.database)}
        }
          catch(err){
            reject('FAILED:'+err.message+ ' '+ sqlconfig.database);
          }
    });
  }

  async getdata(sqlquery) {
    return new Promise(async(resolve, reject) => {
          try{
          var request = await new sql.Request()
          await request.query(sqlquery)
          .then(data=>{
            sql.close();
          resolve(data)
          })
        }
          catch(err){
            reject(err);
          }
    });
  }
}
module.exports = Database;