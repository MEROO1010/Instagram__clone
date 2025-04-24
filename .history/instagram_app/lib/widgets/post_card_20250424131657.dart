import 'package:flutter/material.dart';
import '../models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback? onLike;
  final VoidCallback? onTap;

  const PostCard({required this.post, this.onLike, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              post.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(post.caption ?? '', style: TextStyle(fontSize: 16)),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: post.likes.isNotEmpty ? Colors.red : Colors.grey,
                  ),
                  onPressed: onLike,
                ),
                Text('${post.likes.length} likes'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
