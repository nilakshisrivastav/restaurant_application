// lib/screens/cart_screen.dart
import 'package:flutter/material.dart';
import '../cart/cart_manager.dart';
import '../utils/language.dart';
import '../services/api_service.dart';

class CartScreen extends StatefulWidget {
  final String languageCode;

  const CartScreen({super.key, required this.languageCode});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartManager cartManager = CartManager();

  void _placeOrder() async {
    final items = cartManager.items;
    if (items.isEmpty) return;

    final totalAmount = cartManager.netTotal.toStringAsFixed(0);
    final totalItems = items.length;

    final List<Map<String, dynamic>> orderData = items.map((item) {
      return {
        "cuisine_id": item.dish.cuisineId,
        "item_id": int.parse(item.dish.id),
        "item_price": item.dish.price.toInt(),
        "item_quantity": item.quantity,
      };
    }).toList();

    final response = await ApiService.makePayment(
      totalAmount: totalAmount,
      totalItems: totalItems,
      data: orderData,
    );

    if (response != null && response['response_code'] == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(LanguageStrings.get(widget.languageCode, 'order_success'))),
      );
      setState(() {
        cartManager.clearCart();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment failed!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final grouped = cartManager.groupedByCuisine();

    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageStrings.get(widget.languageCode, 'cart')),
        backgroundColor: Colors.deepPurple,
      ),
      body: cartManager.items.isEmpty
          ? Center(
              child: Text(LanguageStrings.get(widget.languageCode, 'empty_cart')),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(12),
                    children: grouped.entries.map((entry) {
                      final cuisineId = entry.key;
                      final items = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cuisine ID: $cuisineId',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ...items.map((item) {
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                leading: Image.network(
                                  item.dish.imageUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(item.dish.name),
                                subtitle: Text('₹${item.dish.price} x ${item.quantity}'),
                                trailing: SizedBox(
                                  width: 90,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove_circle_outline, size: 20),
                                            onPressed: () {
                                              setState(() {
                                                cartManager.decreaseQuantity(item.dish);
                                              });
                                            },
                                          ),
                                          Text('${item.quantity}'),
                                          IconButton(
                                            icon: const Icon(Icons.add_circle_outline, size: 20),
                                            onPressed: () {
                                              setState(() {
                                                cartManager.addDish(item.dish);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '₹${(item.dish.price * item.quantity).toStringAsFixed(0)}',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                          const Divider(thickness: 1),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildPriceRow(LanguageStrings.get(widget.languageCode, 'net_total'), cartManager.netTotal),
                      _buildPriceRow(LanguageStrings.get(widget.languageCode, 'cgst'), cartManager.cgst),
                      _buildPriceRow(LanguageStrings.get(widget.languageCode, 'sgst'), cartManager.sgst),
                      const Divider(),
                      _buildPriceRow(
                        LanguageStrings.get(widget.languageCode, 'grand_total'),
                        cartManager.grandTotal,
                        isBold: true,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _placeOrder,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        ),
                        child: Text(
                          LanguageStrings.get(widget.languageCode, 'place_order'),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text('₹${amount.toStringAsFixed(2)}', style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
