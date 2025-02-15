import 'package:flutter/material.dart';
import 'package:food_delivery/models/hotel.dart';
import 'package:food_delivery/components/my_food_tile.dart';

class HotelDetailPage extends StatelessWidget {
  final Hotel hotel;
  const HotelDetailPage({Key? key, required this.hotel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hotel.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(hotel.imageUrl, width: double.infinity, height: 200, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(hotel.address, style: const TextStyle(fontSize: 16)),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Menu", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: hotel.foods.length,
              itemBuilder: (context, index) {
                return FoodTile(food: hotel.foods[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
