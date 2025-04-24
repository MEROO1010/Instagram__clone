import 'comment.dart';

class Post {
  final String id;
  final String userId;
  final String imageUrl;
  final String? caption;
  final List<String> likes;
  final List<Comment> comments;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.userId,
    required this.imageUrl,
    this.caption,
    required this.likes,
    required this.comments,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      userId: json['user'],
      imageUrl: json['imageUrl'],
      caption: json['caption'],
      likes: List<String>.from(json['likes'] ?? []),
      comments:
          (json['comments'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': userId,
      'imageUrl': imageUrl,
      'caption': caption,
      'likes': likes,
      'comments': comments.map((c) => c.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
