const Comment = require('../models/Comment');

exports.addComment = async (req, res) => {
  try {
    const { postId, text } = req.body;
    const comment = await Comment.create({ post: postId, user: req.user.id, text });
    res.status(201).json(comment);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.getComments = async (req, res) => {
  try {
    const comments = await Comment.find({ post: req.params.postId }).populate('user', 'username');
    res.json(comments);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
