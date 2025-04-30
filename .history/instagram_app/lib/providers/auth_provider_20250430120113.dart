import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instagram_app/models/user.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  String? _token;
  bool _isAuthenticated = false;
  String? errorMessage;

  bool get isAuthenticated => _isAuthenticated;
  UserModel? get user => _user;
  String? get token => _token;

  // Replace with your actual API base URL
  final String _baseUrl = 'http://localhost:5000';

  Future<bool> signup(String username, String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/signup');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        _user = UserModel.fromJson(data['user']);
        _token = data['token'];
        _isAuthenticated = true;
        errorMessage = null;
        notifyListeners();
        return true;
      } else {
        final data = jsonDecode(response.body);
        errorMessage = data['message'] ?? 'Signup failed';
        return false;
      }
    } catch (e) {
      errorMessage = 'An error occurred: $e';
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _user = UserModel.fromJson(data['user']);
        _token = data['token'];
        _isAuthenticated = true;
        errorMessage = null;
        notifyListeners();
        return true;
      } else {
        final data = jsonDecode(response.body);
        errorMessage = data['message'] ?? 'Login failed';
        return false;
      }
    } catch (e) {
      errorMessage = 'An error occurred: $e';
      return false;
    }
  }

  void logout() {
    _user = null;
    _token = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> loadUser() async {}
}
