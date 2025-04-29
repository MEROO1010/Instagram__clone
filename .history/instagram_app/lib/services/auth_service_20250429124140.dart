import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:instagram_app/models/user.dart';

class AuthService {
  final String baseUrl =
      'http://10.0.2.2:5000/api/auth'; // if running locally on Android emulator

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
        user: UserModel.fromJson(data['user']),
        token: data['token'],
      );
    } else {
      final error = _parseError(response);
      throw Exception(error);
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
        user: UserModel.fromJson(data['user']),
        token: data['token'],
      );
    } else {
      final error = _parseError(response);
      throw Exception(error);
    }
  }

  String _parseError(http.Response response) {
    try {
      final data = jsonDecode(response.body);
      return data['message'] ?? 'Unexpected error occurred.';
    } catch (_) {
      return 'Unexpected error occurred.';
    }
  }
}

class AuthResponse {
  final UserModel user;
  final String token;

  AuthResponse({required this.user, required this.token});
}
