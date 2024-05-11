import 'package:flutter/material.dart';

class UserProfilePicture extends StatelessWidget {
  final String? imageUrl;

  const UserProfilePicture({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 28,
        backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
        child: imageUrl == null ? const Icon(Icons.person, size: 28) : null,
      ),
    );
  }
}
