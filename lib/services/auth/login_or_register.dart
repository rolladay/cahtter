import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:flutter/material.dart';

class LogInOrRegister extends StatefulWidget {
  const LogInOrRegister({super.key});

  @override
  State<LogInOrRegister> createState() => _LogInOrRegisterState();
}

class _LogInOrRegisterState extends State<LogInOrRegister> {
  bool isLogIn = true;

  void toggleLogIn() {
    setState(() {
      isLogIn = !isLogIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLogIn
        ? LoginPage(
            toggle: toggleLogIn,
          )
        : RegisterPage(
            toggle: toggleLogIn,
          );
  }
}
