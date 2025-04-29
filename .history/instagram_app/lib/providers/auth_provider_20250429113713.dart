import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;
  bool get isAuthenticated => _token != null && _user != null;

  Future<bool> signup(String username, String email, String password) async {
    try {
      final response = await _authService.signup(username, email, password);
      _user = response.user;
      _token = response.token;
      notifyListeners();
      return true;
    } catch (e) {
      throw Exception('Signup failed: ${e.toString()}');
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await _authService.login(email, password);
      _user = response.user;
      _token = response.token;
      notifyListeners();
      return true;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  void logout() {
    _user = null;
    _token = null;
    notifyListeners();
  }
}
