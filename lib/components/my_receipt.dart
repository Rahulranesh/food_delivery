import 'package:flutter/material.dart';

class MyReceipt extends StatelessWidget {
  final String receipt;

  const MyReceipt({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 50),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Thank you for the order!'),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.secondary),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(25),
              child: Text(receipt),
            ),
          ],
        ),
      ),
    );
  }
}
