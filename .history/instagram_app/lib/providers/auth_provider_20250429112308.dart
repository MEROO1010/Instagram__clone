import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  String? _token;

  bool get isAuthenticated => _user != null && _token != null;
  User? get user => _user;
  String? get token => _token;

  Future<void> signup(String username, String email, String password) async {
    final authService = AuthService();
    final response = await authService.signup(username, email, password);
    _token = response['token'];
    _user = User.fromJson(response['user'] as Map<String, dynamic>);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final authService = AuthService();
    final response = await authService.login(email, password);
    _token = response['token'];
    _user = User.fromJson(response['user']);
    notifyListeners();
  }

  void logout() {
    _user = null;
    _token = null;
    notifyListeners();
  }

  Future<void> loadUser() async {}
}

extension on User {
  String? operator [](String other) {}
}
