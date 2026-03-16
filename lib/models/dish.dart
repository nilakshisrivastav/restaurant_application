// lib/models/dish.dart

class Dish {
  final String id;
  final String cuisineId;
  final String name;
  final String imageUrl;
  final double price;
  final double rating;
  int quantity;

  Dish({
    required this.id,
    required this.cuisineId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    this.quantity = 1,
  });

  factory Dish.fromJson(Map<String, dynamic> json, String cuisineId) {
    return Dish(
      id: json['id'].toString(),
      cuisineId: cuisineId,
      name: json['name'],
      imageUrl: json['image_url'],
      price: double.tryParse(json['price'].toString()) ?? 0,
      rating: double.tryParse(json['rating'].toString()) ?? 0,
    );
  }
}
