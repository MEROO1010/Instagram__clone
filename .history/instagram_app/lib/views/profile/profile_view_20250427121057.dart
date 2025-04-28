import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/user.dart';

class ProfileView extends StatefulWidget {
  final String userId;

  const ProfileView({super.key, required this.userId});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<void> _userFuture;

  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (auth.token != null) {
      _userFuture = userProvider.fetchUser(widget.userId, auth.token!);
    } else {
      _userFuture =
          Future.value(); // Just create an empty future to avoid crash
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

    if (auth.token == null || auth.user == null) {
      // If user is not logged in
      return Scaffold(
        body: Center(child: Text('You must be logged in to view this page.')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userProvider.selectedUser == null) {
            return const Center(child: Text('User not found.'));
          }

          User user = userProvider.selectedUser!;
          bool isFollowing = user.followers.contains(auth.user!.id);

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    user.avatar ?? 'https://via.placeholder.com/150',
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  user.username,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user.bio ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (isFollowing) {
                      await userProvider.unfollow(user.id, auth.token!);
                    } else {
                      await userProvider.follow(user.id, auth.token!);
                    }
                    setState(() {}); // Refresh UI
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isFollowing ? Colors.grey[300] : Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    isFollowing ? 'Unfollow' : 'Follow',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),

                // You can add user posts here
              ],
            ),
          );
        },
      ),
    );
  }
}
