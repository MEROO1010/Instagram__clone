import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';

class ProfileView extends StatelessWidget {
  final String userId;

  const ProfileView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context);

    final currentUserId = auth.user?.id;
    if (currentUserId == null) {
      return const Scaffold(
        body: Center(child: Text('Please log in to view the profile.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: FutureBuilder<void>(
        future: userProvider.fetchUser(userId, auth.token!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final user = userProvider.selectedUser;
          if (user == null) {
            return const Center(child: Text('User not found.'));
          }

          final isFollowing = user.followers.contains(currentUserId);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.avatar ?? ''),
                  backgroundColor: Colors.grey.shade300,
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
                if (currentUserId != user.id)
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        if (isFollowing) {
                          await userProvider.unfollow(user.id, auth.token!);
                        } else {
                          await userProvider.follow(user.id, auth.token!);
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Action failed: $e')),
                        );
                      }
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
