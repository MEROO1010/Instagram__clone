const express = require('express');
const router = express.Router();
const { addComment, getComments } = require('../controllers/comment.controller');
const authMiddleware = require('../middlewares/auth.middleware');

router.get('/:postId', authMiddleware, getComments);
router.post('/', authMiddleware, addComment);

module.exports = router;
