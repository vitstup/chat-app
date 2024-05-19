import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  bool isLoginPageNow = true;

  void togglePages(){
    setState(() {
      isLoginPageNow = !isLoginPageNow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoginPageNow ? LoginPage(onRegisterTap: togglePages) : RegisterPage(onLoginTap: togglePages);
  }
}