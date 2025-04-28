import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  get token => null;

  get user => null;

  bool? get isLoggedIn => null;

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    // Call your API login endpoint
    // If login success:

    // Here fake response for example:
    bool success = (email == 'test@example.com' && password == 'password123');

    if (success) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', 'fake_jwt_token');

      _isAuthenticated = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> signup(String email, String password, String text) async {
    // Similar logic to login
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', 'fake_jwt_token');

    _isAuthenticated = true;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _isAuthenticated = false;
    notifyListeners();
  }
}
