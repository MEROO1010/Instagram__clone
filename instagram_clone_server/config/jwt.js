const jwt = require('jsonwebtoken');

exports.generateToken = (userId) => {
  return jwt.sign({ id: userId }, process.env.JWT_SECRET || 'secret_key', {
    expiresIn: '7d',
  });
};

exports.verifyToken = (req, res, next) => {
  const token = req.header('Authorization')?.replace('Bearer ', '');
  if (!token) return res.status(401).json({ msg: 'No token, auth denied' });

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET || 'secret_key');
    req.user = decoded;
    next();
  } catch (err) {
    res.status(401).json({ msg: 'Token is not valid' });
  }
};
