import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const UserAvatar({required this.imageUrl, this.radius = 24, super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}
