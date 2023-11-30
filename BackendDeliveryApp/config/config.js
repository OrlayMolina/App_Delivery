const mysql = require('mysql');
require('dotenv').config();

const db = mysql.createConnection({
    host : 'localhost',
    port : 3307,
    user : 'root',
    password : process.env.PASSWORD,
    database : 'udemy_delivery'
});

db.connect(function(err){
    if(err) throw err;
    console.log('Database Connected!');
});

module.exports = db;