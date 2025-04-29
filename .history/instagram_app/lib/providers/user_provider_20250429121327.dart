import 'package:flutter/material.dart';
import 'package:instagram_app/models/user.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  UserModel? _selectedUser;

  UserModel? get selectedUser => _selectedUser;

  Future<void> fetchUser(String userId, String token) async {
    try {
      final user = await _userService.getUser(userId, token);
      _selectedUser = user;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> follow(String userId, String token) async {
    try {
      await _userService.followUser(userId, token);
      await fetchUser(userId, token); // Refresh user data
    } catch (e) {
      rethrow;
    }
  }

  Future<void> unfollow(String userId, String token) async {
    try {
      await _userService.unfollowUser(userId, token);
      await fetchUser(userId, token); // Refresh user data
    } catch (e) {
      rethrow;
    }
  }
}
