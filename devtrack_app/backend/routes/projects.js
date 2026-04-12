const express = require('express');
const router = express.Router();
const db = require('../db');

// CREATE PROJECT
router.post('/create', (req, res) => {
  const { user_id, title, description, stage, support_needed, visibility } = req.body;

  const sql = `
    INSERT INTO projects (user_id, title, description, stage, support_needed, visibility)
    VALUES (?, ?, ?, ?, ?, ?)
  `;

  db.query(
    sql,
    [user_id, title, description, stage, support_needed, visibility],
    (err, result) => {
      if (err) {
        console.log("SQL ERROR:", err);
        return res.json({ success: false, message: err.message });
      }

      res.json({ success: true, message: "Project created" });
    }
  );
});

// GET PUBLIC PROJECTS
router.get('/', (req, res) => {
  const sql = "SELECT * FROM projects WHERE visibility = 'public' ORDER BY id DESC";

  db.query(sql, (err, results) => {
    if (err) {
      console.log("SQL ERROR:", err);
      return res.json([]);
    }

    res.json(results);
  });
});

// GET COMPLETED PROJECTS
router.get('/completed', (req, res) => {
  const sql = "SELECT * FROM projects WHERE stage = 'Completed' ORDER BY id DESC";

  db.query(sql, (err, results) => {
    if (err) {
      console.log("SQL ERROR:", err);
      return res.json([]);
    }

    res.json(results);
  });
});

// UPDATE PROJECT STAGE
router.put('/update-stage/:id', (req, res) => {
  const { stage } = req.body;
  const { id } = req.params;

  const sql = "UPDATE projects SET stage = ? WHERE id = ?";

  db.query(sql, [stage, id], (err, result) => {
    if (err) {
      console.log("SQL ERROR:", err);
      return res.json({ success: false, message: err.message });
    }

    res.json({ success: true, message: "Project stage updated" });
  });
});

module.exports = router;