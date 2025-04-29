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
    final response = await AuthService.signup(username, email, password);
    _token = response['token'];
    _user = User.fromJson(response['user']);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final response = await AuthService.login(email, password);
    _token = response['token'];
    _user = User.fromJson(response['user']);
    notifyListeners();
  }

  void logout() {
    _user = null;
    _token = null;
    notifyListeners();
  }
}
