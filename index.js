// app.js
const express = require('express');
const dotenv = require('dotenv');
const authRoutes = require('./routes/auth');
const authenticateToken = require('./middlewares/auth');

dotenv.config();
const app = express();
app.use(express.json());

// Routes
app.use('/auth', authRoutes);

// Protected Route Example
app.get('/protected', authenticateToken, (req, res) => {
    res.json({ message: `Hello, ${req.user.username}!` });
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
