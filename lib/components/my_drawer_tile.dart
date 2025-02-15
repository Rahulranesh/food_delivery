import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onTap;
  const MyDrawerTile({Key? key, required this.icon, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.inversePrimary),
        title: Text(text, style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
        onTap: onTap,
      ),
    );
  }
}
