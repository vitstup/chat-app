import 'dart:typed_data';

import 'package:chat_app/components/my_avatar.dart';
import 'package:chat_app/services/files/avatars_service.dart';
import 'package:flutter/material.dart';

class UserTile extends StatefulWidget {
  final String text;
  final String userID;
  final void Function()? onTap;

  const UserTile({super.key, required this.text, required this.onTap, required this.userID});

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {

  final _avatarService = AvatarService();
  Uint8List? _avatar;

  @override
  void initState() {
    super.initState();

    _loadAvatar();
  }

  Future _loadAvatar() async{
    _avatar = await _avatarService.getAvatar(widget.userID);

    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            MyAvatar(avatar: _avatar, size: 20),

            const SizedBox(width: 15),

            Text(widget.text)
          ]
        )
      )
    );
  }
}