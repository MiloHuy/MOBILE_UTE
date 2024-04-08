import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/common/globs.dart';
import 'package:my_app/model/product.model.dart';

class AllProductByCategoryName {
  static String url = SVKey.getProductByCategory;

  static Future<List<Products>> fetchProductByCategoryName(
      String categoryName) async {
    final response = await http
        .get(Uri.parse(url.replaceFirst(':categoryName', categoryName)));

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
