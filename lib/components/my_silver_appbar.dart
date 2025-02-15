import 'package:flutter/material.dart';
import 'package:food_delivery/pages/cart_page.dart';

class MySilverAppBar extends StatelessWidget {
  final Widget child;
  const MySilverAppBar({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340,
      collapsedHeight: 120,
      title: const Text('SEVAI', style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
          },
          icon: const Icon(Icons.shopping_cart),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.background,
      flexibleSpace: FlexibleSpaceBar(background: child),
    );
  }
}
