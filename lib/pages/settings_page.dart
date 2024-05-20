import 'dart:async';
import 'dart:io';

import 'package:chat_app/components/my_avatar.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:chat_app/services/files/avatars_service.dart';
import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final _auth = AuthService();
  final _avatars = AvatarService();
  final _chatService = ChatService();

  Future _pickImage(BuildContext context) async{
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (img == null) return;

    try {
      var imageBytes = await File(img.path).readAsBytes();

      await _avatars.saveAvatar(_auth.getCurrentUser()!.uid.toString(), imageBytes);
    } 
    catch(e){
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text(e.toString())
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(_auth.getCurrentUser()!.email!),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // change avatar

            StreamBuilder(
              stream: _chatService.getUserStream(_auth.getCurrentUser()!.uid),
              builder: (context, snapshot){
                return MyAvatar(avatar: snapshot.data?["avatar_link"], size: 100, onTap: () => _pickImage(context));
              }
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: BorderRadius.circular(9)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Тёмная тема"),

                  CupertinoSwitch(
                    value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
                    onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).changeTheme(),
                  )
                ]
              )
            )
          ]
        ),
      )
    );
  }
}