import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';

class ProfileView extends StatelessWidget {
  final String userId;

  const ProfileView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: FutureBuilder(
        future: userProvider.fetchUser(userId, auth.token!), // Use token here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.error != null) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          User user = userProvider.selectedUser!;

          // Check if the current user is following this profile
          bool isFollowing = user.followers.contains(
            auth.user,
          ); // Check if the logged-in user is in the followers list

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    user.avatar ?? '',
                  ), // Display the user's avatar
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
                      await userProvider.unfollow(
                        user.id,
                        auth.token!,
                      ); // Unfollow if already following
                    } else {
                      await userProvider.follow(
                        user.id,
                        auth.token!,
                      ); // Follow if not already following
                    }

                    // Refresh the profile after follow/unfollow action
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
