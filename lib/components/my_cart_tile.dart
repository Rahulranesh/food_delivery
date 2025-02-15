import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_quantity_selector.dart';
import 'package:food_delivery/models/cart_item.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, value, child) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Food image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    cartItem.food.imageUrl,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 14),

                // Name and price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.food.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$${cartItem.food.price}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                

                // Increment or decrement quantity
                MyQuantitySelector(
                  food: cartItem.food,
                  onIncrement: () {
                    Provider.of<Restaurant>(context, listen: false).addToCart(
                      cartItem.food,
                      cartItem.selectedAddons,
                    );
                  },
                  quantity: cartItem.quantity,
                  onDecrement: () {
                    Provider.of<Restaurant>(context, listen: false)
                        .removeFromCart(cartItem);
                  },
                ),
              ],
            ),
            if (cartItem.selectedAddons.isNotEmpty)
              SizedBox(height: 10), // Add spacing if there are addons
            if (cartItem.selectedAddons.isNotEmpty)
              SizedBox(
                height: 40, // Adjust height based on your design
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: cartItem.selectedAddons.map((addon) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Row(
                          children: [
                            Text(addon.name),
                            SizedBox(width: 4),
                            Text('\$${addon.price.toStringAsFixed(2)}'),
                          ],
                        ),
                        onSelected: (value) {},
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        shape: StadiumBorder(
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.primary)),
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
