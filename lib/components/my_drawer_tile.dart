import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  final void Function()? onTap;
  final IconData icon;
  final String text;

  const MyDrawerTile({super.key, required this.onTap, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 20),
            Text(text, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
          ]
        )
      )
    );
  }
}