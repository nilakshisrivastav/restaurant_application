import 'package:flutter/material.dart';
import '../cart/cart_manager.dart';
import '../models/dish.dart';
import '../screens/cart_screen.dart';
import '../screens/cuisine_screen.dart';
import '../utils/language.dart';
import '../widgets/cuisine_card.dart';
import '../widgets/dish_tile.dart';

class HomeScreen extends StatefulWidget {
  final String languageCode;

  const HomeScreen({
    super.key,
    required this.languageCode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CartManager cartManager = CartManager();
  late String currentLanguage;

  @override
  void initState() {
    super.initState();
    currentLanguage = widget.languageCode;
  }

  void _toggleLanguage() {
    setState(() {
      currentLanguage = currentLanguage == 'en' ? 'hi' : 'en';
    });
  }

  final List<Map<String, String>> cuisineCategories = [
    {
      'id': '234552',
      'name': 'North Indian',
      'image': 'https://static.vecteezy.com/system/resources/thumbnails/037/920/252/small/ai-generated-an-indian-masala-thali-gudi-padwa-sweets-and-cuisine-concept-photo.jpeg'
    },
    {
      'id': '475674',
      'name': 'Chinese',
      'image': 'https://popmenucloud.com/cdn-cgi/image/width=1920,height=1920,format=auto,fit=scale-down/wlqenuza/a1ccb6d0-30e6-43eb-a599-d8e6e7d840d1.jpg'
    },
    {
      'id': '893453',
      'name': 'Mexican',
      'image': 'https://d4t7t8y8xqo0t.cloudfront.net/resized/750X436/eazytrendz%2F4242%2Ftrend20231214075116.jpg'
    },
    {
      'id': '784326',
      'name': 'South Indian',
      'image': 'https://images.unsplash.com/photo-1668236543090-82eba5ee5976?w=600'
    },
    {
      'id': '472432',
      'name': 'Italian',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfS0WxK8_kMZ5OFHlLwzZBOWfGaR_qOCIsww&s'
    },
    {
      'id': '246893',
      'name': 'Japanese',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/5/57/Oseti.jpg'
    },
    {
      'id': '848264',
      'name': 'Gujarati',
      'image': 'https://dynamic.tourtravelworld.com/blog_images/14-gujarati-dishes-that-you-must-try-when-you-visit-gujarat-20170927121204.jpg'
    },
  ];

  final List<Dish> topDishes = [
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
      cuisineId: '475674',
      name: 'Sweet and Sour Chicken',
      imageUrl: 'https://www.modernhoney.com/wp-content/uploads/2023/01/Sweet-and-Sour-Chicken-3-crop-scaled.jpg',
      price: 250,
      rating: 4.6,
    ),
    Dish(
      id: '3',
      cuisineId: '234552',
      name: 'Aloo Gobhi',
      imageUrl: 'https://ministryofcurry.com/wp-content/uploads/2017/04/Aloo-Gobi-5.jpg',
      price: 120,
      rating: 3.2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageStrings.get(currentLanguage, 'app_title')),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: _toggleLanguage,
            tooltip: currentLanguage == 'en' ? 'Switch to Hindi' : 'अंग्रेज़ी में बदलें',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LanguageStrings.get(currentLanguage, 'cuisines'),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cuisineCategories.length,
                itemBuilder: (context, index) {
                  final cuisine = cuisineCategories[index];
                  return CuisineCard(
                    imageUrl: cuisine['image']!,
                    cuisineName: cuisine['name']!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CuisineScreen(
                            cuisineId: cuisine['id']!,
                            cuisineName: cuisine['name']!,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              LanguageStrings.get(currentLanguage, 'top_dishes'),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.72,
              children: topDishes
                  .map((dish) => DishTile(
                        imageUrl: dish.imageUrl,
                        dishName: dish.name,
                        price: dish.price,
                        rating: dish.rating,
                        onAdd: () {
                          setState(() {
                            cartManager.addDish(dish);
                          });
                        },
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CartScreen(languageCode: currentLanguage),
            ),
          );
        },
      ),
    );
  }
}
