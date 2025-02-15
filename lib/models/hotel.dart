import 'package:cloud_firestore/cloud_firestore.dart';
import 'food.dart';

class Hotel {
  final String id;
  final String name;
  final String address;
  final String imageUrl;
  final double rating;
  final GeoPoint location;
  final List<Food> foods;
  
  Hotel({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.rating,
    required this.location,
    required this.foods,
  });
  
  factory Hotel.fromMap(String id, Map<String, dynamic> data) {
    return Hotel(
      id: id,
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      location: data['location'],
      foods: (data['foods'] as List<dynamic>?)
              ?.map((f) => Food.fromMap(f as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
