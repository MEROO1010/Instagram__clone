const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || 'super_secret_key';
const JWT_EXPIRES_IN = '7d';

/**
 * Generate a new token for a user
 * @param {String} userId
 * @returns {String} JWT token
 */
exports.generateToken = (userId) => {
  return jwt.sign({ id: userId }, JWT_SECRET, { expiresIn: JWT_EXPIRES_IN });
};

/**
 * Middleware to verify token and attach user info
 */
exports.verifyToken = (req, res, next) => {
  const token = req.header('Authorization')?.replace('Bearer ', '');

  if (!token) return res.status(401).json({ msg: 'No token provided' });

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.user = decoded; // contains { id }
    next();
  } catch (err) {
    res.status(401).json({ msg: 'Invalid or expired token' });
  }
};
