import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final chatService = ChatService();
  final authService = AuthService();

  HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Главная"),
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(
      stream: chatService.getUsersStrem(),
      builder: (context, snapshot){
        if (snapshot.hasError){
          return const Text("Ошибка");
        }
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Text("Загрузка...");
        }

        return ListView(
          children: snapshot.data!.map<Widget>((userdata) => _buildUserItem(userdata, context)).toList()
        );
      }
    );
  }

  Widget _buildUserItem(Map<String, dynamic> userData, BuildContext context){
    if(userData["email"] != authService.getCurrentUser()!.email){
      return UserTile(
      text: userData["email"],
      userID: userData["uid"],
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(recieverEmail: userData["email"], recieverId: userData["uid"],))),
    );
    }
    else{
      return Container();
    }
  }
}