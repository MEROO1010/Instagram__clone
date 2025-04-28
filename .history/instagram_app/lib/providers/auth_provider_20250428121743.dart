import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _token;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  String? get token => _token;

  bool? get isAuthenticated => null;

  Future<void> signup(String username, String email, String password) async {
    var url = Uri.parse('http://10.0.2.2:5000/api/auth/signup');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        _isLoggedIn = true;
        notifyListeners();
      } else {
        _isLoggedIn = false;
        notifyListeners();
        throw Exception('Signup failed');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    var url = Uri.parse('http://10.0.2.2:5000/api/auth/login');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        _token = data['token'];
        _isLoggedIn = true;
        notifyListeners();
      } else {
        _isLoggedIn = false;
        notifyListeners();
        throw Exception('Login failed');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> loadUser() async {}
}
