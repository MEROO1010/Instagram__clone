import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/post_provider.dart';
import '../../providers/auth_provider.dart';

class CreatePostView extends StatelessWidget {
  final captionController = TextEditingController();
  final imageUrlController =
      TextEditingController(); // Later: hook to image picker

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('New Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: captionController,
              decoration: InputDecoration(labelText: 'Caption'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await postProvider.createPost(
                  imageUrlController.text,
                  captionController.text,
                  auth.token!,
                );
                Navigator.pop(context);
              },
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
