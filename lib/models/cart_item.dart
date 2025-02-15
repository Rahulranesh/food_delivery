import 'package:food_delivery/models/food.dart';

class CartItem {
  final Food food;
  final List<Addon> selectedAddons;
  int quantity;

  CartItem({
    required this.food,
    required this.selectedAddons,
    this.quantity = 1,
  });

  double get totalPrice {
    double foodPrice = double.tryParse(food.price) ?? 0.0;
    double addonsPrice = selectedAddons.fold(0, (sum, addon) => sum + addon.price);
    return (foodPrice + addonsPrice) * quantity;
  }
}
