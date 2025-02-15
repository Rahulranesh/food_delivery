enum FoodCategory {
  burgers,
  salads,
  sides,
  desserts,
  drinks,
}

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
  final String imagePath;
  final String price;
  final FoodCategory category;
  final List<Addon> availableAddons;

  Food({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.availableAddons,
    required this.category,
  });

  factory Food.fromMap(Map<String, dynamic> data) {
    // Retrieve the availableAddons data from Firestore.
    final availableAddonsData = data['availableAddons'];
    List<dynamic> addonsList;

    if (availableAddonsData is List) {
      addonsList = availableAddonsData;
    } else if (availableAddonsData is Map) {
      addonsList = availableAddonsData.values.toList();
    } else {
      addonsList = [];
    }

    // Filter out any entries that are not maps.
    final List<Addon> addons = addonsList
        .where((addonData) => addonData is Map<String, dynamic>)
        .map((addonData) => Addon.fromMap(addonData as Map<String, dynamic>))
        .toList();

    return Food(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imagePath: data['imagePath'] ?? '',
      // Convert the price to a string in case it's stored as a number.
      price: (data['price'] ?? '0.00').toString(),
      category: FoodCategory.values.firstWhere(
        (e) => e.toString() == 'FoodCategory.${data['category']}',
        orElse: () => FoodCategory.burgers,
      ),
      availableAddons: addons,
    );
  }
}
