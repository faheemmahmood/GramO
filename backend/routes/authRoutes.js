const express = require('express');
const router = express.Router();

// Mock database
const users = []; // You should replace this with actual DB logic

// POST route for sign-up
router.post('/signup', (req, res) => {
  const { username, password } = req.body;
  if (!username || !password) {
    return res.status(400).json({ message: "Username and password are required" });
  }
  
  // Check if the user already exists
  const existingUser = users.find(user => user.username === username);
  if (existingUser) {
    return res.status(400).json({ message: "User already exists" });
  }
  
  // Simulating storing the user in the DB
  users.push({ username, password });

  return res.status(200).json({ message: 'User signed up successfully' });
});

// POST route for login
router.post('/login', (req, res) => {
  const { username, password } = req.body;
  if (!username || !password) {
    return res.status(400).json({ message: "Username and password are required" });
  }

  // Check if the user exists
  const user = users.find(user => user.username === username);
  if (!user || user.password !== password) {
    return res.status(400).json({ message: "Invalid credentials" });
  }

  // Simulate generating a token (this is just a placeholder, replace with JWT or another method)
  const token = 'mock-jwt-token'; // You should generate an actual token using something like JWT

  return res.status(200).json({ token });
});

module.exports = router;
