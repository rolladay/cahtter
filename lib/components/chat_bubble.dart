import 'package:chatapp/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key,
      required this.message,
      // required this.user,
      required this.isCurrentUser});
  // final String user;
  final String message;
  final bool isCurrentUser;



  @override
  Widget build(BuildContext context) {

    bool isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.teal : (isDarkMode ? Colors.orange : Colors.lightBlue),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
