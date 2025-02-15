enum FoodCategory { burgers, salads, sides, desserts, drinks }

class Addon {
  final String name;
  final double price;
  Addon({required this.name, required this.price});
  factory Addon.fromMap(Map<String, dynamic> data) {
    return Addon(
      name: data['name'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Food {
  final String name;
  final String description;
  final String imageUrl;
  final String price;
  final FoodCategory category;
  final List<Addon> availableAddons;
  Food({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.availableAddons,
    required this.category,
  });
  factory Food.fromMap(Map<String, dynamic> data) {
    return Food(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: data['price']?.toString() ?? '0.00',
      category: FoodCategory.values.firstWhere(
          (e) => e.toString() == 'FoodCategory.${data['category']}',
          orElse: () => FoodCategory.burgers),
      availableAddons: (data['availableAddons'] as List<dynamic>?)
              ?.map((a) => Addon.fromMap(a as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
