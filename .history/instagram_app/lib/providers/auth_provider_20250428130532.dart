import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _userId;

  late String token;
  bool get isAuthenticated => _token != null;

  get user => null;

  // Method to handle signup
  Future<void> signup(String username, String email, String password) async {
    const url = 'http://localhost:5000/signup'; // Replace with your API URL

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      // Successfully signed up
      final responseData = json.decode(response.body);
      // You can save the token or user data here if needed
      _token = responseData['token'];
      _userId = responseData['user']['id'];
      notifyListeners();
    } else {
      // Signup failed
      final errorMessage = json.decode(response.body)['message'];
      throw Exception(errorMessage); // You can customize this error handling
    }
  }

  // Example method to check login or load user details
  Future<void> loadUser() async {
    // Add logic for loading user if needed
  }

  Future<void> login(String text, String text2) async {}
}
