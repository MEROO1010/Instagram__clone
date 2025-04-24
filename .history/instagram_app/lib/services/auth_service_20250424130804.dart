import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:5000/api/auth';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {'user': User.fromJson(data['user']), 'token': data['token']};
    } else {
      throw Exception('Login failed');
    }
  }

  Future<User> signup(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data['user']);
    } else {
      throw Exception('Signup failed');
    }
  }
}
