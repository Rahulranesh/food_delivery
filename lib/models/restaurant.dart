import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:food_delivery/models/hotel.dart';
import 'package:food_delivery/models/cart_item.dart';
import 'package:food_delivery/models/food.dart';

class Restaurant extends ChangeNotifier {
  List<Hotel> _hotels = [];
  List<Hotel> get hotels => _hotels;
  
  // Currently selected hotel (if any)
  Hotel? selectedHotel;
  
  // Delivery address and coordinates
  String _deliveryAddress = 'Fetching...';
  String get deliveryAddress => _deliveryAddress;
  GeoPoint? _deliveryCoordinates;
  GeoPoint? get deliveryCoordinates => _deliveryCoordinates;
  
  // Cart and Favourites
  final List<CartItem> _cart = [];
  List<CartItem> get cart => _cart;
  final List<Food> _favourites = [];
  List<Food> get favourites => _favourites;
  
  Restaurant() {
    fetchHotels();
  }
  
  Future<void> fetchHotels() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('hotels').get();
    _hotels = snapshot.docs.map((doc) => Hotel.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList();
    notifyListeners();
  }
  
  void selectHotel(Hotel hotel) {
    selectedHotel = hotel;
    notifyListeners();
  }
  
  void addToCart(Food food, [List<Addon> selectedAddons = const []]) {
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
List<Food> get popularFoods {
  List<Food> foods = [];
  for (var hotel in _hotels) {
    if (hotel.foods.isNotEmpty) {
      foods.add(hotel.foods[0]); // You can modify this logic as needed.
    }
  }
  return foods;
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
    receiptBuffer.writeln('Grand Total: \$${cart.fold(0.0, (sum, item) => sum + item.totalPrice).toStringAsFixed(2)}');
    receiptBuffer.writeln('Thank you for your order!');
    return receiptBuffer.toString()
  }
}
