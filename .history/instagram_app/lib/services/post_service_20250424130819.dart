import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostService {
  static const String baseUrl = 'http://localhost:5000/api/posts';

  Future<List<Post>> getFeed(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/feed'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch feed');
    }
  }

  Future<Post> createPost(String imageUrl, String caption, String token) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'imageUrl': imageUrl, 'caption': caption}),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<void> likePost(String postId, String token) async {
    await http.post(
      Uri.parse('$baseUrl/$postId/like'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<void> unlikePost(String postId, String token) async {
    await http.delete(
      Uri.parse('$baseUrl/$postId/unlike'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
