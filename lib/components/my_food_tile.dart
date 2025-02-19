import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/restaurant.dart';

import 'package:food_delivery/pages/my_food_page.dart';
import 'package:provider/provider.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  const FoodTile({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Tapping anywhere on the tile (except the plus icon) navigates to FoodPage.
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FoodPage(food: food)),
            );
          },
          child: Card(
            margin: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Use AspectRatio to ensure image is a portrait rectangle.
                Expanded(
                  flex: 3,
                  child: AspectRatio(
                    aspectRatio: 3 / 4, // 3:4 ratio: taller than wide.
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image.asset(
                        food.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(food.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('\$${food.price}',
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.primary)),
                        const SizedBox(height: 4),
                        Text(food.description,
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Plus icon overlay for favourites.
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () {
              Provider.of<Restaurant>(context, listen: false).addToFavourites(food);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${food.name} added to favourites')),
              );
            },
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.redAccent, // Visible red color.
              child: const Icon(Icons.add, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
