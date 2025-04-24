import 'package:flutter/material.dart';
import '../models/comment.dart';
import '../services/comment_service.dart';

class CommentProvider with ChangeNotifier {
  final CommentService _commentService = CommentService();
  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  Future<void> fetchComments(String postId, String token) async {
    _comments = await _commentService.getComments(postId, token);
    notifyListeners();
  }

  Future<void> addComment(String postId, String text, String token) async {
    Comment newComment = await _commentService.addComment(postId, text, token);
    _comments.add(newComment);
    notifyListeners();
  }

  Future<void> deleteComment(String commentId, String token) async {
    await _commentService.deleteComment(commentId, token);
    _comments.removeWhere((c) => c.id == commentId);
    notifyListeners();
  }
}
