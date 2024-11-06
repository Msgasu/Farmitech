// routes/auth.js
const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const pool = require('../db');
require('dotenv').config();

const router = express.Router();
const saltRounds = 10;

// Register User
router.post('/register', async (req, res) => {
    const { username, password } = req.body;
    try {
        const hashedPassword = await bcrypt.hash(password, saltRounds);
        const newUser = await pool.query(
            'INSERT INTO users (username, password) VALUES ($1, $2) RETURNING *',
            [username, hashedPassword]
        );
        res.status(201).json({ message: 'User registered successfully!' });
    } catch (err) {
        if (err.code === '23505') {
            res.status(400).json({ error: 'Username already exists' });
        } else {
            res.status(500).json({ error: 'Server error' });
        }
    }
});

// Login User
router.post('/login', async (req, res) => {
    const { username, password } = req.body;
    try {
        const user = await pool.query(
            'SELECT * FROM users WHERE username = $1',
            [username]
        );

        if (user.rows.length === 0) {
            return res.status(400).json({ error: 'User not found' });
        }

        const validPassword = await bcrypt.compare(password, user.rows[0].password);
        if (!validPassword) {
            return res.status(400).json({ error: 'Invalid password' });
        }

        const token = jwt.sign({ id: user.rows[0].id, username }, process.env.JWT_SECRET, {
            expiresIn: '1h',
        });
        res.json({ token });
    } catch (err) {
        res.status(500).json({ error: 'Server error' });
    }
});

module.exports = router;
