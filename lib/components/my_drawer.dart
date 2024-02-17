import 'package:chatapp/pages/setting_page.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';



class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logOut() {
    final AuthService auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: Icon(
                    Icons.accessibility_new_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home,
                      color: Theme.of(context).colorScheme.primary),
                  title: Text(
                    'H O M E',
                  ),
                  onTap: Navigator.of(context).pop,
                ),
                ListTile(
                  leading: Icon(Icons.settings,
                      color: Theme.of(context).colorScheme.primary),
                  title: Text(
                    'S E T T I N G S',
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MySettings(),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ListTile(
                leading: Icon(Icons.logout,
                    color: Theme.of(context).colorScheme.primary),
                title: Text(
                  'Log Out',
                ),
                onTap: logOut,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
