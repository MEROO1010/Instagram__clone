import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/comment_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/comment.dart';

class PostDetailView extends StatelessWidget {
  final String postId;
  PostDetailView({required this.postId});

  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Comments')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: commentProvider.fetchComments(postId, auth.token!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());

                return ListView.builder(
                  itemCount: commentProvider.comments.length,
                  itemBuilder: (context, index) {
                    final Comment comment = commentProvider.comments[index];
                    return ListTile(
                      title: Text(comment.text),
                      subtitle: Text('By ${comment.userId}'),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TextField(controller: commentController)),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    await commentProvider.addComment(
                      postId,
                      commentController.text,
                      auth.token!,
                    );
                    commentController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
