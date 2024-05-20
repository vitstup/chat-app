import 'package:flutter/material.dart';

class MyAvatar extends StatelessWidget {
  final String? avatar;
  final double size;
  final void Function()? onTap;

  const MyAvatar({super.key, this.avatar, this.onTap, required this.size});

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: SizedBox.fromSize(
          size: Size.fromRadius(size),
          child: avatar != null ?
            Image.network(avatar!, fit: BoxFit.cover) :
            Icon(Icons.person, size: size)
        ),
      ),
    );
  }
}
