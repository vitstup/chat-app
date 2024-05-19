import 'dart:typed_data';

import 'package:flutter/material.dart';

class MyAvatar extends StatelessWidget {
  final Uint8List? avatar;
  final double? size;
  final void Function()? onTap;

  const MyAvatar({super.key, this.avatar, this.onTap, this.size});

  @override
  Widget build(BuildContext context) {
    return avatar != null
        ? GestureDetector(
            onTap: onTap,
            child:
                CircleAvatar(radius: size, backgroundImage: MemoryImage(avatar!)))
        : GestureDetector(
            onTap: onTap, child: Icon(Icons.person, size: size));
  }
}
