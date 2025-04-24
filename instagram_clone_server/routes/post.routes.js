const express = require('express');
const router = express.Router();
const { createPost, getFeed, likePost } = require('../controllers/post.controller');
const authMiddleware = require('../middlewares/auth.middleware');
const multer = require('multer');

// File upload setup
const upload = multer({ dest: 'uploads/' });

router.get('/feed', authMiddleware, getFeed);
router.post('/', authMiddleware, upload.single('image'), createPost);
router.post('/like/:id', authMiddleware, likePost);

module.exports = router;
