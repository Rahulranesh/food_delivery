// models/restaurant.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/cart_item.dart';

class Restaurant extends ChangeNotifier {
  List<Food> _menu = [];
  List<Food> get menu => _menu;
  
  // Delivery address (initially a placeholder)
  String _deliveryAddress = 'Fetching...';
  String get deliveryAddress => _deliveryAddress;
  
  // User cart
  final List<CartItem> _cart = [];
  List<CartItem> get cart => _cart;

  Restaurant() {
    fetchMenu();
    // Optionally, fetch a saved delivery address from the user profile here.
  }

  Future<void> fetchMenu() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('foods').get();
    _menu = snapshot.docs
        .map((doc) => Food.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  // --- Cart and order functions remain as before ---
  void addToCart(Food food, List<Addon> selectedAddons) {
    // [Your addToCart implementation...]
  }

  void removeFromCart(CartItem cartItem) {
    // [Your removeFromCart implementation...]
  }

  double getTotalPrice() {
    // [Your total price calculation...]
    double total = 0.0;
    for (var cartItem in _cart) {
      double itemPrice = double.tryParse(cartItem.food.price) ?? 0.0;
      double addonsPrice = cartItem.selectedAddons.fold(0.0, (sum, addon) => sum + addon.price);
      total += (itemPrice + addonsPrice) * cartItem.quantity;
    }
    return total;
  }

  int getTotalItemCount() {
    return _cart.fold(0, (total, item) => total + item.quantity);
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }

  String generateReceipt() {
    // [Your receipt generation code...]
    StringBuffer receiptBuffer = StringBuffer();
    receiptBuffer.writeln('Receipt:');
    receiptBuffer.writeln('------------------------');

    for (var cartItem in _cart) {
      receiptBuffer.writeln('${cartItem.food.name} x${cartItem.quantity}');
      for (var addon in cartItem.selectedAddons) {
        receiptBuffer.writeln('  - ${addon.name}: \$${addon.price.toStringAsFixed(2)}');
      }
      double itemTotal = ((double.tryParse(cartItem.food.price) ?? 0.0) +
              cartItem.selectedAddons.fold(0.0, (sum, addon) => sum + addon.price)) *
          cartItem.quantity;
      receiptBuffer.writeln('  Total: \$${itemTotal.toStringAsFixed(2)}');
    }
    receiptBuffer.writeln('------------------------');
    receiptBuffer.writeln('Grand Total: \$${getTotalPrice().toStringAsFixed(2)}');
    receiptBuffer.writeln('Thank you for your order!');
    return receiptBuffer.toString();
  }
}
