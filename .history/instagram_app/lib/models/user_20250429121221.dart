class UserModel {
  final String id;
  final String username;
  final String email;
  final String? avatar;
  final String? bio;
  final List<String> followers;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.avatar,
    this.bio,
    required this.followers,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      avatar: json['avatar'],
      bio: json['bio'],
      followers: List<String>.from(json['followers'] ?? []),
    );
  }
}
