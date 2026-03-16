// lib/screens/cuisine_screen.dart
import 'package:flutter/material.dart';
import '../models/dish.dart';
import '../cart/cart_manager.dart';

class CuisineScreen extends StatefulWidget {
  final String cuisineId;
  final String cuisineName;

  const CuisineScreen({
    super.key,
    required this.cuisineId,
    required this.cuisineName,
  });

  @override
  State<CuisineScreen> createState() => _CuisineScreenState();
}

class _CuisineScreenState extends State<CuisineScreen> {
  final CartManager cartManager = CartManager();

  final List<Dish> allDishes = [
    Dish(
      id: '1',
      cuisineId: '234552',
      name: 'Butter Chicken',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRk2ENrVHHd_Hs-MqVFhxPbJbw-MVe1PmFKDQ&s',
      price: 199,
      rating: 4.5,
    ),
    Dish(
      id: '2',
      cuisineId: '234552',
      name: 'Aloo Gobhi',
      imageUrl: 'https://ministryofcurry.com/wp-content/uploads/2017/04/Aloo-Gobi-5.jpg',
      price: 120,
      rating: 3.2,
    ),
    Dish(
      id: '3',
      cuisineId: '234552',
      name: 'Paneer Butter Masala',
      imageUrl: 'https://www.ruchiskitchen.com/wp-content/uploads/2020/12/Paneer-butter-masala-recipe-3-500x500.jpg',
      price: 180,
      rating: 4.1,
    ),
    Dish(
      id: '4',
      cuisineId: '475674',
      name: 'Sweet and Sour Chicken',
      imageUrl: 'https://www.modernhoney.com/wp-content/uploads/2023/01/Sweet-and-Sour-Chicken-3-crop-scaled.jpg',
      price: 250,
      rating: 4.6,
    ),
    Dish(
      id: '5',
      cuisineId: '475674',
      name: 'Veg Hakka Noodles',
      imageUrl: 'https://www.whiskaffair.com/wp-content/uploads/2020/10/Veg-Hakka-Noodles-2-3.jpg',
      price: 150,
      rating: 4.3,
    ),
  ];

  void _addToCart(Dish dish) {
    setState(() {
      cartManager.addDish(dish);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${dish.name} added to cart'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredDishes = allDishes.where((dish) => dish.cuisineId == widget.cuisineId).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cuisineName),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: filteredDishes.length,
          itemBuilder: (context, index) {
            final dish = filteredDishes[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        dish.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 60),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dish.name,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text('₹${dish.price.toStringAsFixed(0)} • ⭐ ${dish.rating}'),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.green),
                      onPressed: () => _addToCart(dish),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
