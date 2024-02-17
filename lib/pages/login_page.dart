
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key, required this.toggle});

  final void Function() toggle;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
        _emailTextController.text,
        _passwordTextController.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Oops $e'),
        ),
      );
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.mail_rounded,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              //welecome msg
              SizedBox(
                height: 60,
              ),
              Text(
                'Hello, Rafa. You`ve been missed',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              //email
              MyTextField(
                hintText: 'Enter e-mail please',
                isObscure: false,
                textController: _emailTextController,
              ),
              SizedBox(
                height: 16,
              ),
              MyTextField(
                hintText: 'Enter Password please',
                isObscure: true,
                textController: _passwordTextController,
              ),
              SizedBox(
                height: 24,
              ),
              MyButton(
                text: 'Log-In',
                onTap: () => login(context),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a memeber? ',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  GestureDetector(
                    onTap: toggle,
                    child: Text(
                      'then Regidter Now.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
