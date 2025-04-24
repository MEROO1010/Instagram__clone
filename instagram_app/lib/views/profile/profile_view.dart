import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/user.dart';

class ProfileView extends StatelessWidget {
  final String userId;
  ProfileView({required this.userId});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: FutureBuilder(
        future: userProvider.fetchUser(userId, auth.token!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          User user = userProvider.selectedUser!;
          bool isFollowing = user.followers.contains(auth.user!.id);

          return Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.avatar ?? ''),
              ),
              Text(user.username, style: TextStyle(fontSize: 20)),
              Text(user.bio ?? ''),
              ElevatedButton(
                onPressed: () {
                  isFollowing
                      ? userProvider.unfollow(user.id, auth.token!)
                      : userProvider.follow(user.id, auth.token!);
                },
                child: Text(isFollowing ? 'Unfollow' : 'Follow'),
              ),
            ],
          );
        },
      ),
    );
  }
}
