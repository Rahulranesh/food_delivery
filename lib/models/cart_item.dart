// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:food_delivery/models/food.dart';

class CartItem {
  Food food;
  List<Addon> selectedAddons;
  int quantity;

  CartItem({
    required this.food,
    required this.selectedAddons,
    this.quantity = 1,
  });

  double get totalPrice {
    // Convert food price from String to double
    double foodPrice = double.parse(food.price);

    // Calculate addons price
    double addonsPrice =
        selectedAddons.fold(0, (sum, addon) => sum + addon.price);

    // Return total price for the cart item
    return (foodPrice + addonsPrice) * quantity;
  }
}
