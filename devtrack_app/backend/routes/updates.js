const express = require('express');
const router = express.Router();
const db = require('../db');

router.post('/', (req, res) => {
  const { project_id, content } = req.body;

  db.query(
    "INSERT INTO updates (project_id, content) VALUES (?, ?)",
    [project_id, content],
    (err) => {
      if (err) return res.send(err);
      res.send("Update added");
    }
  );
});

module.exports = router;