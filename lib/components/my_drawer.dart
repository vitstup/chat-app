import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_drawer_tile.dart';
import 'package:chat_app/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(){
    final auth = AuthService();

    auth.signOut();
  }

  void goToSettings(BuildContext context){
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [

          const SizedBox(height: 40),

          Icon(Icons.message, color: Theme.of(context).colorScheme.primary, size: 40),
          
          const SizedBox(height: 40),

          Divider(color: Theme.of(context).colorScheme.secondary),

          MyDrawerTile(onTap: () => Navigator.pop(context), icon: Icons.home, text: "Главная"),

          const SizedBox(height: 8),

          MyDrawerTile(onTap: () => goToSettings(context), icon: Icons.settings, text: "Настройки"),

          const Spacer(),

          MyDrawerTile(onTap: logout, icon: Icons.logout, text: "Выйти"),

          const SizedBox(height: 25)
        ]
      )
    );
  }
}