import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.toggle});

  final void Function() toggle;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _passwordConfirmTextController =
      TextEditingController();

  void register(BuildContext context) async {
    final auth = AuthService();
    if (_passwordConfirmTextController.text == _passwordTextController.text) {
      try {
        await auth.signUpWithEmailPassword(
            _emailTextController.text, _passwordTextController.text);
      } catch (e) {
        if (context.mounted == false) {
          return;
        } else if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                e.toString(),
              ),
            ),
          );
        }
        print(e);
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text(
            'Password doesn`t match',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
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
              'Let`s create an account for you',
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
            MyTextField(
              hintText: 'confirm Password please',
              isObscure: true,
              textController: _passwordConfirmTextController,
            ),
            SizedBox(
              height: 24,
            ),
            MyButton(
              text: 'Register',
              onTap: () => register(context),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You have an account? ',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  width: 16.0,
                ),
                GestureDetector(
                  onTap: widget.toggle,
                  child: Text(
                    'then Log-in Now.',
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
    );
  }
}
