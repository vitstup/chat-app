import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  final void Function()? onLoginTap;

  RegisterPage({super.key, required this.onLoginTap});

  void register(BuildContext context){
    final auth = AuthService();

    if (passwordController.text == rePasswordController.text){
      try{
        auth.signUpWithEmailPassword(emailController.text, passwordController.text);
      }
      catch(e){
        showDialog(context: context, builder: (context) => AlertDialog(
        title: Text(e.toString())
      ));
      }
    }

    else{
      showDialog(context: context, builder: (context) => const AlertDialog(
        title: Text("Пароли не совпадают")
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

            Text("Давайте вас зарегистрируем", style: TextStyle(color: Theme.of(context).colorScheme.primary)),

            const SizedBox(height: 20),

            MyTextfield(hintText: "Email", obscureText: false, controller: emailController),

            const SizedBox(height: 10),

            MyTextfield(hintText: "Пароль", obscureText: true, controller: passwordController),

            const SizedBox(height: 10),

            MyTextfield(hintText: "Повторите пароль", obscureText: true, controller: rePasswordController),

            const SizedBox(height: 20),

            MyButton(text: "Зарегистрироваться", onTap: () => register(context)),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Уже зарегистрированы?", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: onLoginTap,
                  child: Text("Войти", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)))
              ]
            )
          ],
        ),
      ),
    );
  }
}