// lib/cart/cart_manager.dart

import '../models/dish.dart';

class CartItem {
  final Dish dish;
  int quantity;

  CartItem({required this.dish, this.quantity = 1});

  double get totalPrice => dish.price * quantity;
}

class CartManager {
  static final CartManager _instance = CartManager._internal();

  factory CartManager() => _instance;

  CartManager._internal();

  final Map<String, CartItem> _items = {};

  // Get list of cart items
  List<CartItem> get items => _items.values.toList();

  // Grouped by cuisine
  Map<String, List<CartItem>> get itemsByCuisine {
    final Map<String, List<CartItem>> grouped = {};
    for (var item in _items.values) {
      final cuisineId = item.dish.cuisineId;
      grouped.putIfAbsent(cuisineId, () => []).add(item);
    }
    return grouped;
  }

  void addDish(Dish dish) {
    if (_items.containsKey(dish.id)) {
      _items[dish.id]!.quantity++;
    } else {
      _items[dish.id] = CartItem(dish: dish);
    }
  }

  void removeDish(Dish dish) {
    _items.remove(dish.id);
  }

  void increaseQuantity(Dish dish) {
    if (_items.containsKey(dish.id)) {
      _items[dish.id]!.quantity++;
    }
  }

  void decreaseQuantity(Dish dish) {
    if (_items.containsKey(dish.id)) {
      if (_items[dish.id]!.quantity > 1) {
        _items[dish.id]!.quantity--;
      } else {
        _items.remove(dish.id);
      }
    }
  }

  void clearCart() {
    _items.clear();
  }

  double get netTotal {
    return _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double get cgst => netTotal * 0.025;
  double get sgst => netTotal * 0.025;
  double get grandTotal => netTotal + cgst + sgst;

  int get totalItems => _items.length;

  List<Map<String, dynamic>> get orderData => _items.values.map((item) {
        return {
          'cuisine_id': item.dish.cuisineId,
          'item_id': int.tryParse(item.dish.id) ?? 0,
          'item_price': item.dish.price,
          'item_quantity': item.quantity,
        };
      }).toList();

  /// Used in cart screen to group cart items by cuisine
  Map<String, List<CartItem>> groupedByCuisine() {
    final Map<String, List<CartItem>> grouped = {};
    for (var item in _items.values) {
      final cuisineId = item.dish.cuisineId;
      grouped.putIfAbsent(cuisineId, () => []).add(item);
    }
    return grouped;
  }
}
