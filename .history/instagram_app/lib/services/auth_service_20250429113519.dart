import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthService {
  final String baseUrl =
      'http://localhost:5000/api/auth'; // Replace with your backend URL

  Future<AuthResponse> signup(
    String username,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return AuthResponse(
        user: User.fromJson(data['user']),
        token: data['token'],
      );
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<AuthResponse> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return AuthResponse(
        user: User.fromJson(data['user']),
        token: data['token'],
      );
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}

class AuthResponse {
  final User user;
  final String token;

  AuthResponse({required this.user, required this.token});
}
