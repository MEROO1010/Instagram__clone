import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:instagram_app/models/user.dart';

class UserService {
  static const String baseUrl = 'http://localhost:5000/api/users';

  Future<UserModel> getUser(String id, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to fetch user');
    }
  }

  Future<void> followUser(String id, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$id/follow'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to follow user');
    }
  }

  Future<void> unfollowUser(String id, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id/unfollow'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to unfollow user');
    }
  }
}
