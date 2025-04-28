import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _userId;
  bool _isAuthenticated = false;

  String? get token => _token;
  String? get userId => _userId;
  bool get isAuthenticated => _isAuthenticated;

  // To handle signup logic
  Future<void> signup(String username, String email, String password) async {
    try {
      final dio = Dio();
      final response = await dio.post(
        'http://localhost:5000/api/auth/signup', // Ensure the correct endpoint
        data: {'username': username, 'email': email, 'password': password},
      );

      if (response.statusCode == 201) {
        // If signup successful, automatically log in
        await login(email, password);
      } else {
        throw Exception("Signup failed. Try again.");
      }
    } catch (error) {
      throw Exception("Signup failed. Try again.");
    }
  }

  // Login method to authenticate the user
  Future<void> login(String email, String password) async {
    try {
      final dio = Dio();
      final response = await dio.post(
        'http://localhost:5000/api/auth/login', // Your login API endpoint
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        _token = response.data['token'];
        _userId = response.data['user']['id'];
        _isAuthenticated = true;
        notifyListeners();
      } else {
        throw Exception("Invalid email or password");
      }
    } catch (error) {
      throw Exception("Login failed. Try again.");
    }
  }

  // Method to load user data (for splash screen logic)
  Future<void> loadUser() async {
    // Simulating fetching user data from local storage
    if (_token != null) {
      _isAuthenticated = true;
      notifyListeners();
    }
  }
}
