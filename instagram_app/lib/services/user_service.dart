import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  static const String baseUrl = 'http://localhost:5000/api/users';

  Future<User> getUser(String id, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch user');
    }
  }

  Future<void> followUser(String id, String token) async {
    await http.post(
      Uri.parse('$baseUrl/$id/follow'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<void> unfollowUser(String id, String token) async {
    await http.delete(
      Uri.parse('$baseUrl/$id/unfollow'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
