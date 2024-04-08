import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/common/globs.dart';
import 'package:my_app/model/order.model.dart';
import 'package:my_app/model/product.model.dart';

class AddToCart {
  static String url = SVKey.addToCart;

  static Future<List<Products>> handleAddToCart(Orders product) async {
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode(product),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      final List<dynamic> productsData = jsonData['data'];

      List<Products> products = productsData
          .map((json) => Products.fromJSON(json as Map<String, dynamic>))
          .toList();

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
