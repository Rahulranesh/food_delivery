import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_drawer_tile.dart';
import 'package:food_delivery/pages/settings_page.dart';
import 'package:food_delivery/pages/order_history.dart';
import 'package:food_delivery/services/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  void logout(BuildContext context) {
    final authService = AuthService();
    authService.signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Icon(Icons.lock_open_rounded,
                size: 40, color: Theme.of(context).colorScheme.inversePrimary),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(color: Theme.of(context).colorScheme.secondary),
          ),
          MyDrawerTile(
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
            text: 'H O M E',
          ),
          MyDrawerTile(
            icon: Icons.history,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const OrderHistoryPage()));
            },
            text: 'O R D E R  H I S T O R Y',
          ),
          MyDrawerTile(
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const SettingsPage()));
            },
            text: 'S E T T I N G S',
          ),
          const Spacer(),
          MyDrawerTile(
            icon: Icons.logout,
            onTap: () => logout(context),
            text: 'L O G O U T',
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
