import 'package:flutter/material.dart';

class PostDetailView extends StatelessWidget {
  final String postId;

  const PostDetailView({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    // You would normally fetch post data from your provider or API
    return Scaffold(
      appBar: AppBar(title: Text('Post Detail')),
      body: Center(
        child: Text('Details of post $postId will be displayed here'),
      ),
    );
  }
}
