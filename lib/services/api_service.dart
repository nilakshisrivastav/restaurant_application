// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://uat.onebanc.ai/emulator/interview';

  static const Map<String, String> baseHeaders = {
    'X-Partner-API-Key': 'uonebancservceemultrS3cg8RaL30',
    'Content-Type': 'application/json',
  };

  // 1. Get List of Cuisines + Dishes
  static Future<Map<String, dynamic>?> getItemList({int page = 1, int count = 10}) async {
    final url = Uri.parse('$baseUrl/get_item_list');
    final body = jsonEncode({'page': page, 'count': count});

    final response = await http.post(
      url,
      headers: {
        ...baseHeaders,
        'X-Forward-Proxy-Action': 'get_item_list',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // 2. Get Item Details by ID
  static Future<Map<String, dynamic>?> getItemById(int itemId) async {
    final url = Uri.parse('$baseUrl/get_item_by_id');
    final body = jsonEncode({'item_id': itemId});

    final response = await http.post(
      url,
      headers: {
        ...baseHeaders,
        'X-Forward-Proxy-Action': 'get_item_by_id',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // 3. Filter Items
  static Future<Map<String, dynamic>?> getItemByFilter({
    List<String>? cuisineType,
    int? minAmount,
    int? maxAmount,
    int? minRating,
  }) async {
    final url = Uri.parse('$baseUrl/get_item_by_filter');

    Map<String, dynamic> filterBody = {};
    if (cuisineType != null) filterBody['cuisine_type'] = cuisineType;
    if (minAmount != null && maxAmount != null) {
      filterBody['price_range'] = {
        'min_amount': minAmount,
        'max_amount': maxAmount,
      };
    }
    if (minRating != null) filterBody['min_rating'] = minRating;

    final response = await http.post(
      url,
      headers: {
        ...baseHeaders,
        'X-Forward-Proxy-Action': 'get_item_by_filter',
      },
      body: jsonEncode(filterBody),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // 4. Make Payment
  static Future<Map<String, dynamic>?> makePayment({
    required String totalAmount,
    required int totalItems,
    required List<Map<String, dynamic>> data,
  }) async {
    final url = Uri.parse('$baseUrl/make_payment');

    final body = jsonEncode({
      'total_amount': totalAmount,
      'total_items': totalItems,
      'data': data,
    });

    final response = await http.post(
      url,
      headers: {
        ...baseHeaders,
        'X-Forward-Proxy-Action': 'make_payment',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}
