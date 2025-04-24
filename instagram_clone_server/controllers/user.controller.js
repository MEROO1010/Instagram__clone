const User = require('../models/User');

exports.getUser = async (req, res) => {
  try {
    const user = await User.findById(req.params.id).select('-password');
    res.json(user);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.followUser = async (req, res) => {
  try {
    const targetId = req.params.id;
    const currentUser = req.user;

    await User.findByIdAndUpdate(targetId, { $addToSet: { followers: currentUser.id } });
    await User.findByIdAndUpdate(currentUser.id, { $addToSet: { following: targetId } });

    res.json({ msg: 'Followed' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.unfollowUser = async (req, res) => {
  try {
    const targetId = req.params.id;
    const currentUser = req.user;

    await User.findByIdAndUpdate(targetId, { $pull: { followers: currentUser.id } });
    await User.findByIdAndUpdate(currentUser.id, { $pull: { following: targetId } });

    res.json({ msg: 'Unfollowed' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
