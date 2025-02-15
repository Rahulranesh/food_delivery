import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/cart_item.dart';

class Restaurant extends ChangeNotifier {
  List<Food> _menu = [];
  List<Food> get menu => _menu;

  // Delivery address and coordinates
  String _deliveryAddress = 'Fetching...';
  String get deliveryAddress => _deliveryAddress;
  GeoPoint? _deliveryCoordinates;
  GeoPoint? get deliveryCoordinates => _deliveryCoordinates;

  // User cart
  final List<CartItem> _cart = [];
  List<CartItem> get cart => _cart;

  // Favourites list
  final List<Food> _favourites = [];
  List<Food> get favourites => _favourites;

  Restaurant() {
    fetchMenu();
  }

  Future<void> fetchMenu() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('foods').get();
    _menu = snapshot.docs
        .map((doc) => Food.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  void addToCart(Food food, [List<Addon> selectedAddons = const []]) {
    // Simplified: add item with quantity 1
    _cart.add(CartItem(food: food, selectedAddons: selectedAddons));
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    int index = _cart.indexOf(cartItem);
    if (index != -1) {
      if (_cart[index].quantity > 1) {
        _cart[index].quantity--;
      } else {
        _cart.removeAt(index);
      }
      notifyListeners();
    }
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var cartItem in _cart) {
      double foodPrice = double.tryParse(cartItem.food.price) ?? 0.0;
      double addonsPrice = cartItem.selectedAddons.fold(0.0, (sum, addon) => sum + addon.price);
      total += (foodPrice + addonsPrice) * cartItem.quantity;
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

  void updateDeliveryCoordinates(GeoPoint coordinates) {
    _deliveryCoordinates = coordinates;
    notifyListeners();
  }

  void addToFavourites(Food food) {
    if (!_favourites.contains(food)) {
      _favourites.add(food);
      notifyListeners();
    }
  }

  void removeFromFavourites(Food food) {
    _favourites.remove(food);
    notifyListeners();
  }

  String generateReceipt() {
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
