const express = require('express');
const router = express.Router();
const db = require('../db');

// CREATE PROJECT
router.post('/create', (req, res) => {
  const { user_id, title, description, stage, support_needed } = req.body;

  console.log("REQUEST BODY:", req.body);

  const sql = `
    INSERT INTO projects (user_id, title, description, stage, support_needed)
    VALUES (?, ?, ?, ?, ?)
  `;

  db.query(
    sql,
    [user_id, title, description, stage, support_needed],
    (err, result) => {
      if (err) {
        console.log("SQL ERROR:", err);
        return res.json({ success: false, message: err.message });
      }

      res.json({ success: true, message: "Project created" });
    }
  );
});

module.exports = router;