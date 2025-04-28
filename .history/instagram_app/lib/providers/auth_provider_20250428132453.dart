import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _token;
  String? _userId;

  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;
  String? get userId => _userId;

  // Signup Method
  Future<void> signup(String username, String email, String password) async {
    const url =
        'http://localhost:5000/api/auth/signup'; // Replace with your API URL
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 201) {
      _token = responseData['token'];
      _userId = responseData['user']['id'];
      _isAuthenticated = true;
      notifyListeners();
    } else {
      throw Exception(responseData['message']);
    }
  }

  Future<void> login(String text, String text2) async {}
}
