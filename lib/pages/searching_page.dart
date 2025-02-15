import 'package:flutter/material.dart';
import 'package:food_delivery/models/hotel.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery/pages/hotel_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";
  @override
  Widget build(BuildContext context) {
    final restaurants = Provider.of<Restaurant>(context).hotels;
    List<Hotel> hotelResults = restaurants.where((hotel) {
      return hotel.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    // Also search foods: find hotels that contain a food matching the query.
    List<Hotel> foodResults = restaurants.where((hotel) {
      return hotel.foods.any((food) => food.name.toLowerCase().contains(query.toLowerCase()));
    }).toList();
    // Combine and remove duplicates.
    List<Hotel> results = {...hotelResults, ...foodResults}.toList();
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(labelText: "Search hotels or food"),
              onChanged: (val) {
                setState(() {
                  query = val;
                });
              },
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? const Center(child: Text("No results found"))
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      Hotel hotel = results[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Image.network(
                            hotel.imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          title: Text(hotel.name),
                          subtitle: Text(hotel.address),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HotelDetailPage(hotel: hotel)),
                            );
                          },
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
