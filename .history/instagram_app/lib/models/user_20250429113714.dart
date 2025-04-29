class User {
  final String id;
  final String username;
  final String email;
  final String? avatar;
  final String? bio;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.avatar,
    this.bio,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      avatar: json['avatar'],
      bio: json['bio'],
    );
  }
}
