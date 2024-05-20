import 'package:chat_app/components/my_avatar.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String recieverEmail;
  final String recieverId;
  final String? recieverAvatarUrl;

  ChatPage({super.key, required this.recieverEmail, required this.recieverId, required this.recieverAvatarUrl});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();

  final chatService = ChatService();

  final authService = AuthService();


  final focusNode = FocusNode();

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() { 
      if(focusNode.hasFocus){
        Future.delayed(const Duration(microseconds: 700), () => scrollDown());
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    messageController.dispose();
    super.dispose();
  }

  void scrollDown(){
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(microseconds: 700),
      curve: Curves.bounceInOut
    );
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty){
      await chatService.sendMessage(widget.recieverId, messageController.text);

      messageController.clear();
    }

    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            MyAvatar(onTap: (){}, size: 20, avatar: widget.recieverAvatarUrl),
            const SizedBox(width: 8),
            Text(widget.recieverEmail)
          ]
        ),
        //centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
        child: Column(
          children: [
            Expanded(child: _buildMessageList()),

            const SizedBox(height: 12),
        
            _buildUserInput()
          ]
        ),
      )
    );
  }

  Widget _buildMessageList(){
    String senderId = authService.getCurrentUser()!.uid;

    return StreamBuilder(
      stream: chatService.getMessages(widget.recieverId, senderId),
      builder: (context, snapshot){
        if (snapshot.hasError){
          return const Text("Ошибка");
        }

        if (snapshot.connectionState == ConnectionState.waiting){
          return const Text("Загрузка...");
        }

        return ListView(
          controller: scrollController,
          children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList()
        );
      }
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderId'] == authService.getCurrentUser()!.uid;

    return Column(
      crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.green : Colors.grey,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Text(data["message"])
        )
      ]
    );
  }

  Widget _buildUserInput(){
    return Row(
      children: [
        Expanded(
          child: MyTextfield(
            controller: messageController,
            focusNode: focusNode,
            hintText: "Введите сообщение",
            obscureText: false,
          )
        ),

        const SizedBox(width: 20),

        Container(
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle
          ),
          child: IconButton(onPressed: sendMessage, icon: const Icon(Icons.arrow_upward), color: Colors.white))
      ]
    );
  }
}