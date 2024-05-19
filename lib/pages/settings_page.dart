import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:chat_app/components/my_avatar.dart';
import 'package:chat_app/services/auth/auth_service.dart';
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

  Uint8List? _avatar;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
    _loadAvatar();
  });
  }

  Future _loadAvatar() async{
    _avatar = await _avatars.getAvatar(_auth.getCurrentUser()!.uid.toString());

    if (mounted){
      setState(() {
      
      });
    }
  }

  Future _pickImage(BuildContext context) async{
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (img == null) return;

    try {
      var imageBytes = await File(img.path).readAsBytes();

      await _avatars.saveAvatar(_auth.getCurrentUser()!.uid.toString(), imageBytes);

      setState(() {
        _avatar = imageBytes;
      });
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

            MyAvatar(avatar: _avatar, size: 100, onTap: () => _pickImage(context)),

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