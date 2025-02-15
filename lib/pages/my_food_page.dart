import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  // Maintain a map of add-on selections.
  final Map<Addon, bool> selectedAddons = {};
  FoodPage({Key? key, required this.food}) : super(key: key) {
    for (Addon addon in food.availableAddons) {
      selectedAddons[addon] = false;
    }
  }
  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  void addToCart() {
    List<Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.food.availableAddons) {
      if (widget.selectedAddons[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }
    Provider.of<Restaurant>(context, listen: false)
        .addToCart(widget.food, currentlySelectedAddons);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.food.name} added to cart')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.food.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.food.imageUrl,
                width: double.infinity, height: 250, fit: BoxFit.cover),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(widget.food.description,
                  style: const TextStyle(fontSize: 16)),
            ),
            if (widget.food.availableAddons.isNotEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Select Add-ons',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            if (widget.food.availableAddons.isNotEmpty)
              const Divider(),
            if (widget.food.availableAddons.isNotEmpty)
              ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.food.availableAddons.length,
                itemBuilder: (context, index) {
                  final addon = widget.food.availableAddons[index];
                  return CheckboxListTile(
                    value: widget.selectedAddons[addon],
                    onChanged: (bool? value) {
                      setState(() {
                        widget.selectedAddons[addon] = value!;
                      });
                    },
                    title: Text(addon.name),
                    subtitle:
                        Text('\$${addon.price.toStringAsFixed(2)}'),
                  );
                },
              ),
            const SizedBox(height: 20),
            Center(child: MyButton(onTap: addToCart, text: 'Add to Cart')),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
