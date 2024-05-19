import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final void Function()? onRegisterTap;

  LoginPage({super.key, required this.onRegisterTap});

  void login(BuildContext context) async{
    final authService = AuthService();

    try{
      await authService.signInWithEmailPassword(emailController.text, passwordController.text);
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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message, color: Theme.of(context).colorScheme.primary, size: 40),

            Text("Привет, мы давно вас ждём!", style: TextStyle(color: Theme.of(context).colorScheme.primary)),

            const SizedBox(height: 20),

            MyTextfield(hintText: "Email", obscureText: false, controller: emailController),

            const SizedBox(height: 10),

            MyTextfield(hintText: "Пароль", obscureText: true, controller: passwordController),

            const SizedBox(height: 20),

            MyButton(text: "Войти", onTap: () => login(context)),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Не зарегистрированы?", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: onRegisterTap,
                  child: Text("Зарегистрируйся", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)))
              ]
            )
          ],
        ),
      ),
    );
  }
}