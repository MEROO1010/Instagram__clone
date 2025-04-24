import 'package:flutter/material.dart';
import '../models/comment.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;

  const CommentTile({required this.comment, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(comment.text),
      subtitle: Text('by ${comment.userId}'), // Optional: load username by ID
    );
  }
}
