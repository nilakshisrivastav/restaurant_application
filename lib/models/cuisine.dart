// lib/models/cuisine.dart

import 'dish.dart';

class Cuisine {
  final String id;
  final String name;
  final String imageUrl;
  final List<Dish> dishes;

  Cuisine({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.dishes,
  });

  factory Cuisine.fromJson(Map<String, dynamic> json) {
    List<Dish> dishList = [];
    if (json['items'] != null) {
      dishList = (json['items'] as List)
          .map((item) => Dish.fromJson(item, json['cuisine_id']))
          .toList();
    }

    return Cuisine(
      id: json['cuisine_id'].toString(),
      name: json['cuisine_name'],
      imageUrl: json['cuisine_image_url'],
      dishes: dishList,
    );
  }
}
