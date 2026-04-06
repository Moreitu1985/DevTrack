const express = require('express');
const router = express.Router();
const db = require('../db');

// CREATE PROJECT
router.post('/', (req, res) => {
  const { user_id, title, description, stage, support_needed } = req.body;

  const sql = `
    INSERT INTO projects (user_id, title, description, stage, support_needed)
    VALUES (?, ?, ?, ?, ?)
  `;

  db.query(sql, [user_id, title, description, stage, support_needed], (err, result) => {
    if (err) {
      console.log(err);
      return res.json({ success: false, message: "Insert failed" });
    }

    res.json({ success: true, message: "Project created" });
  });
});

// GET PROJECTS
router.get('/', (req, res) => {
  const sql = "SELECT * FROM projects";

  db.query(sql, (err, results) => {
    if (err) return res.json([]);

    res.json(results);
  });
});

module.exports = router;