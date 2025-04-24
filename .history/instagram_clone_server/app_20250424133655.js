const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const errorMiddleware = require('./middlewares/error.middleware');

const authRoutes = require('./routes/auth.routes');
const userRoutes = require('./routes/user.routes');
const postRoutes = require('./routes/post.routes');
const commentRoutes = require('./routes/comment.routes');

const app = express();

// Middleware
app.use(express.json());
app.use(cors());
app.use(morgan('dev'));
app.use('/uploads', express.static('uploads')); // Serve static images

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes);
app.use('/api/posts', postRoutes);
app.use('/api/comments', commentRoutes);

// Error handling
app.use(errorMiddleware);

module.exports = app;
