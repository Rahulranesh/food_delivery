import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery/models/restaurant.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  const FoodTile({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            // Add to cart when the tile is tapped
            Provider.of<Restaurant>(context, listen: false).addToCart(food);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${food.name} added to cart')),
            );
          },
          child: Card(
            margin: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Image.asset(
                    food.imagePath,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(food.name,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('\$${food.price}',
                            style: TextStyle(
                                fontSize: 14, color: Theme.of(context).colorScheme.primary)),
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
        // Plus icon overlay for adding to favourites
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
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Icons.add, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
