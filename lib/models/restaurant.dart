import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:food_delivery/models/cart_item.dart';
import 'package:food_delivery/models/food.dart';

class Restaurant extends ChangeNotifier {
  // List of food menu
  List<Food> _menu = _initializeMenu();

  // Getters
  List<Food> get menu => _menu;
  String get deliveryAddress => _deliveryAddress;

  // User cart
  final List<CartItem> _cart = [];
  List<CartItem> get cart => _cart;

  // Delivery address
  String _deliveryAddress = 'GCT, Thadagam Road, Coimbatore';

  // Initialize menu items
  static List<Food> _initializeMenu() {
    return [
      Food(
        name: 'Classic CheeseBurger',
        description: 'A Juicy Beef with melted cheddar',
        imagePath: 'images/burgers/burger1.jpg',
        price: '0.99',
        availableAddons: [
          Addon(name: 'Extra Cheese', price: 0.89),
          Addon(name: 'Extra Bacon', price: 0.69),
          Addon(name: 'Extra Avocado', price: 1.89),
        ],
        category: FoodCategory.burgers,
      ),
      Food(
        name: 'BBQ Burger',
        description: 'A Juicy Tendered with maximal stuffing',
        imagePath: 'images/burgers/burger2.jpg',
        price: '1.99',
        availableAddons: [
          Addon(name: 'Extra Cheese', price: 0.89),
          Addon(name: 'Extra Bacon', price: 0.69),
          Addon(name: 'Extra Avocado', price: 1.89),
        ],
        category: FoodCategory.burgers,
      ),
      Food(
        name: 'KFC Burger',
        description: 'Brings you the best of Burgers from KFC',
        imagePath: 'images/burgers/burger3.jpg',
        price: '0.70',
        availableAddons: [
          Addon(name: 'Extra Cheese', price: 0.89),
          Addon(name: 'Extra Bacon', price: 0.69),
          Addon(name: 'Extra Avocado', price: 1.89),
        ],
        category: FoodCategory.burgers,
      ),
      Food(
        name: 'HeatSquare Special Burger',
        description: 'A Juicy Beef with melted cheddar',
        imagePath: 'images/burgers/burger4.jpg',
        price: '1.35',
        availableAddons: [
          Addon(name: 'Extra Cheese', price: 0.89),
          Addon(name: 'Extra Bacon', price: 0.69),
          Addon(name: 'Extra Avocado', price: 1.89),
        ],
        category: FoodCategory.burgers,
      ),
      Food(
          name: 'Veg Salad',
          description: 'Salad with fresh vegetables',
          imagePath: 'images/salads/salad1.jpg',
          price: '0.99',
          availableAddons: [
            Addon(name: 'Extra Cheese', price: 0.89),
            Addon(name: 'Extra Bacon', price: 0.69),
            Addon(name: 'Extra Avocado', price: 1.89),
          ],
          category: FoodCategory.salads),
      Food(
          name: 'Fruit Salad',
          description: 'Salad with fresh Fruit',
          imagePath: 'images/salads/salad2.jpg',
          price: '2.99',
          availableAddons: [
            Addon(name: 'Extra Cheese', price: 0.89),
            Addon(name: 'Extra Bacon', price: 0.69),
            Addon(name: 'Extra Avocado', price: 1.89),
          ],
          category: FoodCategory.salads),
      Food(
          name: 'Mixed Salad',
          description: 'Salad with fresh vegetables and fruits',
          imagePath: 'images/salads/salad3.jpg',
          price: '1.99',
          availableAddons: [
            Addon(name: 'Extra Cheese', price: 0.89),
            Addon(name: 'Extra Bacon', price: 0.69),
            Addon(name: 'Extra Avocado', price: 1.89),
          ],
          category: FoodCategory.salads),
      Food(
          name: 'Paneer Salad',
          description: 'Salad with fresh Paneer',
          imagePath: 'images/salads/salad4.jpg',
          price: '1.60',
          availableAddons: [
            Addon(name: 'Extra Cheese', price: 0.89),
            Addon(name: 'Extra Bacon', price: 0.69),
            Addon(name: 'Extra Avocado', price: 1.89),
          ],
          category: FoodCategory.salads),

      // Sides
      Food(
          name: 'Chicken Side',
          description: 'Chicken Side for any Combo!',
          imagePath: 'images/sides/sides1.jpg',
          price: '1.60',
          availableAddons: [
            Addon(name: 'Extra Cheese', price: 0.89),
            Addon(name: 'Extra Bacon', price: 0.69),
            Addon(name: 'Extra Avocado', price: 1.89),
          ],
          category: FoodCategory.sides),
      Food(
          name: 'Chicken Side (Hot and Spicy)',
          description: 'Chicken Side for any Combo! and Special Masala',
          imagePath: 'images/sides/sides2.jpg',
          price: '1.60',
          availableAddons: [
            Addon(name: 'Extra Cheese', price: 0.89),
            Addon(name: 'Extra Bacon', price: 0.69),
            Addon(name: 'Extra Avocado', price: 1.89),
          ],
          category: FoodCategory.sides),
      Food(
          name: 'Chicken Side (Ghost (HOT))',
          description: 'Chicken Side for any Combo! (HOT AND SPICY)',
          imagePath: 'images/sides/sides3.jpg',
          price: '1.60',
          availableAddons: [
            Addon(name: 'Extra Cheese', price: 0.89),
            Addon(name: 'Extra Bacon', price: 0.69),
            Addon(name: 'Extra Avocado', price: 1.89),
          ],
          category: FoodCategory.sides),
      Food(
          name: 'Mutton Side',
          description: 'Mutton Side for any Combo!',
          imagePath: 'images/sides/sides4.jpg',
          price: '1.60',
          availableAddons: [
            Addon(name: 'Extra Cheese', price: 0.89),
            Addon(name: 'Extra Bacon', price: 0.69),
            Addon(name: 'Extra Avocado', price: 1.89),
          ],
          category: FoodCategory.sides),

      // Desserts
      Food(
          name: 'Ice on a Potty',
          description: 'Favourite Ice-Cream for kids to Adults',
          imagePath: 'images/desserts/desserts1.jpg',
          price: '1.60',
          availableAddons: [],
          category: FoodCategory.desserts),
      Food(
          name: 'Ice on a Potty',
          description: 'Favourite Ice-Cream for kids to Adults',
          imagePath: 'images/desserts/desserts2.jpg',
          price: '1.60',
          availableAddons: [],
          category: FoodCategory.desserts),
      Food(
          name: 'Chocolate',
          description:
              'Favourite Chocolate for kids to Adults! Chill and feel the feel!!',
          imagePath: 'images/desserts/desserts4.jpg',
          price: '1.60',
          availableAddons: [],
          category: FoodCategory.desserts),
      Food(
          name: 'Cake',
          description: 'Favourite Cake for kids to Adults',
          imagePath: 'images/desserts/desserts3.jpg',
          price: '1.60',
          availableAddons: [],
          category: FoodCategory.desserts),

      // Drinks
      Food(
          name: 'Soda',
          description: 'Soda it! Now!!',
          imagePath: 'images/drinks/drink1.jpg',
          price: '1.60',
          availableAddons: [Addon(name: 'Ice-Cubes', price: 0)],
          category: FoodCategory.drinks),
      Food(
          name: 'Lime',
          description: 'Best for Summer',
          imagePath: 'images/drinks/drink2.jpg',
          price: '1.60',
          availableAddons: [Addon(name: 'Ice-Cubes', price: 0)],
          category: FoodCategory.drinks),
      Food(
          name: 'Mojito-Red',
          description: 'Soda and lime in one - MOJITO',
          imagePath: 'images/drinks/drink3.jpg',
          price: '1.60',
          availableAddons: [Addon(name: 'Ice-Cubes', price: 0)],
          category: FoodCategory.drinks),
      Food(
          name: 'Mint Lime',
          description: 'Flavoured Lime with mint',
          imagePath: 'images/drinks/drink4.jpg',
          price: '1.60',
          availableAddons: [Addon(name: 'Ice-Cubes', price: 0)],
          category: FoodCategory.drinks),
      // Other food items as in your list...
    ];
  }

  // Add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) =>
        item.food == food &&
        ListEquality().equals(item.selectedAddons, selectedAddons));

    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(CartItem(food: food, selectedAddons: selectedAddons));
    }
    notifyListeners();
  }

  // Remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);
    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
      notifyListeners();
    }
  }

  // Get total price of cart
  double getTotalPrice() {
    double total = 0.0;
    for (CartItem cartItem in _cart) {
      double itemTotal = _parsePrice(cartItem.food.price);
      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

  // Get total number of items in the cart
  int getTotalItemCount() {
    return _cart.fold(0, (total, item) => total + item.quantity);
  }

  // Clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // Update delivery address
  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }

  // Generate a receipt for the current cart
  String generateReceipt() {
    StringBuffer receiptBuffer = StringBuffer();
    receiptBuffer.writeln('Receipt:');
    receiptBuffer.writeln('------------------------');

    for (CartItem cartItem in _cart) {
      receiptBuffer.writeln('${cartItem.food.name} x${cartItem.quantity}');
      for (Addon addon in cartItem.selectedAddons) {
        receiptBuffer
            .writeln('  - ${addon.name}: ${formatCurrency(addon.price)}');
      }
      double itemTotal = (_parsePrice(cartItem.food.price) +
              cartItem.selectedAddons
                  .fold(0.0, (sum, addon) => sum + addon.price)) *
          cartItem.quantity;
      receiptBuffer.writeln('  Total: ${formatCurrency(itemTotal)}');
    }

    receiptBuffer.writeln('------------------------');
    receiptBuffer.writeln('Grand Total: ${formatCurrency(getTotalPrice())}');
    receiptBuffer.writeln('Thank you for your order!');

    return receiptBuffer.toString();
  }

  // Format double value to currency format
  String formatCurrency(double value) {
    return '\$${value.toStringAsFixed(2)}';
  }

  // Format list of addons into a string summary
  String formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => '${addon.name}: ${formatCurrency(addon.price)}')
        .join(', ');
  }

  // Safely parse price values
  double _parsePrice(String price) {
    try {
      return double.parse(price);
    } catch (e) {
      // Handle parsing error
      return 0.0;
    }
  }
}
