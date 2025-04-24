class Comment {
  final String id;
  final String postId;
  final String userId;
  final String text;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.text,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'],
      postId: json['post'],
      userId: json['user'],
      text: json['text'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'post': postId,
      'user': userId,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
