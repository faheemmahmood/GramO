const express = require("express");
const app = express();
const authRoutes = require("./routes/authRoutes"); // Ensure path is correct
const grammarRoutes = require("./routes/grammarRoutes"); // Add this line
const cors = require("cors");
require('dotenv').config(); // Load environment variables


app.use(cors()); // Allow requests from Flutter
app.use(express.json()); // Parse JSON bodies

// Routes
app.use("/api/auth", authRoutes); // Authentication routes
app.use("/api/grammar", grammarRoutes); // Grammar check routes (fixed this)

// Test route
app.get("/", (req, res) => {
  res.json({ message: "Backend is working." });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({ message: "Route not found" });
});

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`✅ Server is running on port ${PORT}`);
});
