const User = require('../models/User');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { generateToken } = require('../config/jwt');

exports.signup = async (req, res) => {
  try {
    const { username, email, password } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) return res.status(400).json({ msg: 'User already exists' });

    const hash = await bcrypt.hash(password, 10);
    const newUser = await User.create({ username, email, password: hash });

    const token = generateToken(newUser._id);
    res.status(201).json({ token, user: newUser });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });

    if (!user) return res.status(404).json({ msg: 'User not found' });

    const match = await bcrypt.compare(password, user.password);
    if (!match) return res.status(400).json({ msg: 'Invalid credentials' });

    const token = generateToken(user._id);
    res.json({ token, user });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
