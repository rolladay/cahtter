import 'package:chatapp/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

import '../components/my_drawer.dart';
import '../components/my_user_tile.dart';
import '../services/auth/auth_service.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,

        title: const Text('Home'),
      ),
      body: _buildUserList(),
    );
  }

  //build a userList for the current loggedin user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
//error check
        if (snapshot.hasError) {
          return Text('ERROR');
        }
        //loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('LOADING...');
        }

        //return listview
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData2) => _buildUserListItem(userData2, context))
              .toList(),
        );
      },
    );
  }

  //build indivisual user list tile
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
//display all user excpet current user
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatPage(receiverEmail: userData['email'], receiverId: userData['uid'],),
          ),
        ),
        text: userData['email'],
      );
    } else {
      return Container();
    }
  }
}
