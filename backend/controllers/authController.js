const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const users = []; // Temporary storage (use DB later)

// User login
const login = async (req, res) => {
    const { username, password } = req.body;

    // Find user
    const user = users.find(u => u.username === username);
    if (!user) return res.status(400).json({ message: "User not found" });

    // Check password
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ message: "Invalid password" });

    // Generate token
    const token = jwt.sign({ username: user.username }, process.env.JWT_SECRET, { expiresIn: "1h" });

    res.json({ token });
};

// User signup (temporary, replace with DB later)
const signup = async (req, res) => {
    console.log("Received request body:", req.body); // Debugging

    const { username, password } = req.body;
    if (!username || !password) {
        return res.status(400).json({ message: "Username and password required" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    users.push({ username, password: hashedPassword });

    res.json({ message: "User registered successfully" });
};

module.exports = { login, signup };
