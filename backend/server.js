const express = require("express");
const app = express();
const authRoutes = require("./routes/auth_route"); // Correct path
const cors = require("cors");

// MIDDLEWARE
app.use(cors()); // 🔑 Allow requests from Flutter
app.use(express.json()); // 🔑 Parse JSON

// ROUTES
app.use("/api/auth", authRoutes); // All routes will be under /api/auth

// TEST ROOT
app.get("/", (req, res) => {
  res.json({ message: "Backend is working." });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({ message: "Route not found" });
});

// SERVER
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`✅ Server is running on port ${PORT}`);
});
