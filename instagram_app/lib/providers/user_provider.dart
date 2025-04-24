import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  User? _selectedUser;

  User? get selectedUser => _selectedUser;

  Future<void> fetchUser(String userId, String token) async {
    _selectedUser = await _userService.getUser(userId, token);
    notifyListeners();
  }

  Future<void> follow(String userId, String token) async {
    await _userService.followUser(userId, token);
    await fetchUser(userId, token);
  }

  Future<void> unfollow(String userId, String token) async {
    await _userService.unfollowUser(userId, token);
    await fetchUser(userId, token);
  }
}
