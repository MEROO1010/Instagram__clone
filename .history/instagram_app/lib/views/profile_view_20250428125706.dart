import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';

class ProfileView extends StatelessWidget {
  final String userId;
  ProfileView({required this.userId});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: FutureBuilder(
        future: userProvider.fetchUser(userId, auth.token!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.error != null) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          User user = userProvider.selectedUser!;

          // Check if the current user is following this profile
          bool isFollowing = user.followers.contains(auth.userId);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.avatar ?? ''),
                ),
                const SizedBox(height: 12),
                Text(
                  user.username,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  user.bio ?? '',
                  style: TextStyle(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    if (isFollowing) {
                      await userProvider.unfollow(user.id, auth.token!);
                    } else {
                      await userProvider.follow(user.id, auth.token!);
                    }

                    // Refresh the profile after follow/unfollow
                    await userProvider.fetchUser(userId, auth.token!);
                  },
                  child: Text(isFollowing ? 'Unfollow' : 'Follow'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
