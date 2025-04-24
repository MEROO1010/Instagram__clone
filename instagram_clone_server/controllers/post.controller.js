const Post = require('../models/Post');

exports.createPost = async (req, res) => {
  try {
    const { imageUrl, caption } = req.body;
    const newPost = await Post.create({ user: req.user.id, imageUrl, caption });
    res.status(201).json(newPost);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.getFeed = async (req, res) => {
  try {
    const posts = await Post.find().sort({ createdAt: -1 }).populate('user', 'username avatar');
    res.json(posts);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.likePost = async (req, res) => {
  try {
    const post = await Post.findById(req.params.id);

    const hasLiked = post.likes.includes(req.user.id);
    if (hasLiked) {
      post.likes.pull(req.user.id);
    } else {
      post.likes.push(req.user.id);
    }

    await post.save();
    res.json(post);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
