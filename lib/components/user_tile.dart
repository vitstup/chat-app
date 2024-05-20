import 'package:chat_app/components/my_avatar.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String? avatarUrl;
  final void Function()? onTap;

  const UserTile({super.key, required this.text, required this.onTap, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            MyAvatar(avatar: avatarUrl, size: 20),

            const SizedBox(width: 15),

            Text(text)
          ]
        )
      )
    );
  }
}