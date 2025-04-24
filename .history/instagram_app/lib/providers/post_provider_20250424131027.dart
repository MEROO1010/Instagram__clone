import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class PostProvider with ChangeNotifier {
  final PostService _postService = PostService();

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  Future<void> loadFeed(String token) async {
    _posts = await _postService.getFeed(token);
    notifyListeners();
  }

  Future<void> createPost(String imageUrl, String caption, String token) async {
    Post newPost = await _postService.createPost(imageUrl, caption, token);
    _posts.insert(0, newPost);
    notifyListeners();
  }

  Future<void> likePost(String postId, String token) async {
    await _postService.likePost(postId, token);
    await loadFeed(token);
  }

  Future<void> unlikePost(String postId, String token) async {
    await _postService.unlikePost(postId, token);
    await loadFeed(token);
  }
}
