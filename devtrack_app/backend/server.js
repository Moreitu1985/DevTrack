const express = require('express');
const app = express();
const cors = require('cors');

// ✅ 1. CORS FIRST
app.use(cors({
  origin: "*",
  methods: ["GET", "POST", "PUT", "DELETE"],
  allowedHeaders: ["Content-Type"]
}));

// ✅ 2. JSON BODY PARSER
app.use(express.json());

// ROUTES
const authRoutes = require('./routes/auth');
const projectRoutes = require('./routes/projects');

// ✅ 3. USE ROUTES LAST
app.use('/auth', authRoutes);
app.use('/projects', projectRoutes);

app.listen(3000, () => {
  console.log("Server running on port 3000");
});