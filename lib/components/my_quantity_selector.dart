import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';

class MyQuantitySelector extends StatelessWidget {
  final Food food;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const MyQuantitySelector({
    Key? key,
    required this.food,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Decrement button
        IconButton(
          onPressed: onDecrement,
          icon: Icon(Icons.remove),
        ),
        // Display quantity
        Text(
          quantity.toString(),
          style: TextStyle(fontSize: 10),
        ),
        // Increment button
        IconButton(
          onPressed: onIncrement,
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
