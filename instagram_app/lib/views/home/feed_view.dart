import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/post_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/post.dart';

class FeedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Feed')),
      body: FutureBuilder(
        future: postProvider.loadFeed(auth.token!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          return ListView.builder(
            itemCount: postProvider.posts.length,
            itemBuilder: (context, index) {
              final Post post = postProvider.posts[index];
              return ListTile(
                leading: Image.network(post.imageUrl),
                title: Text(post.caption ?? ''),
                subtitle: Text('Likes: ${post.likes.length}'),
              );
            },
          );
        },
      ),
    );
  }
}
