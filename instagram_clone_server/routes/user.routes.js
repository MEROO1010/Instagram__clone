const express = require('express');
const router = express.Router();
const { getUser, followUser, unfollowUser } = require('../controllers/user.controller');
const authMiddleware = require('../middlewares/auth.middleware');

router.get('/:id', authMiddleware, getUser);
router.post('/follow/:id', authMiddleware, followUser);
router.post('/unfollow/:id', authMiddleware, unfollowUser);

module.exports = router;
