const mysql = require('mysql2');

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'password for your database',
  database: 'devtrack'
});

db.connect((err) => {
  if (err) {
    console.log("❌ MySQL Connection Failed:");
    console.log(err.message);
    return;
  }

  console.log("✅ MySQL Connected Successfully");
});

module.exports = db;
