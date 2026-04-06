const express = require('express');
const app = express();
const cors = require('cors');

// ✅ CORS MUST BE HERE (TOP)
app.use(cors()); // simplest fix

// OR better (more controlled)
app.use(cors({
  origin: "*",
  methods: ["GET", "POST", "PUT", "DELETE"],
  allowedHeaders: ["Content-Type"]
}));

app.use(express.json());

// ROUTES
const authRoutes = require('./routes/auth');
app.use('/auth', authRoutes);

app.listen(3000, () => {
  console.log("Server running on port 3000");
});