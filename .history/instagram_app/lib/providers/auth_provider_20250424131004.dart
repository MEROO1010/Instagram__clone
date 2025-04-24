import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;
  bool get isAuthenticated => _token != null;

  final AuthService _authService = AuthService();

  Future<void> login(String email, String password) async {
    final result = await _authService.login(email, password);
    _user = result['user'];
    _token = result['token'];
    notifyListeners();
  }

  Future<void> signup(String username, String email, String password) async {
    _user = await _authService.signup(username, email, password);
    notifyListeners();
  }

  void logout() {
    _user = null;
    _token = null;
    notifyListeners();
  }
}
