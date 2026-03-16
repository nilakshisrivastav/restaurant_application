import 'package:flutter/material.dart';

class DishTile extends StatelessWidget {
  final String imageUrl;
  final String dishName;
  final double price;
  final double rating;
  final VoidCallback onAdd;

  const DishTile({
    super.key,
    required this.imageUrl,
    required this.dishName,
    required this.price,
    required this.rating,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.broken_image)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  dishName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text('₹${price.toStringAsFixed(0)}'),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(rating.toString()),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: onAdd,
                  child: const Text('Add'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
