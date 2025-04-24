import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/comment.dart';

class CommentService {
  static const String baseUrl = 'http://localhost:5000/api/posts';

  Future<List<Comment>> getComments(String postId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$postId/comments'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch comments');
    }
  }

  Future<Comment> addComment(String postId, String text, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$postId/comments'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'text': text}),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Comment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add comment');
    }
  }

  Future<void> deleteComment(String commentId, String token) async {
    final url = 'http://localhost:5000/api/comments/$commentId';
    await http.delete(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
