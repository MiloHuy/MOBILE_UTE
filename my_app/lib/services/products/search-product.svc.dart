import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/common/globs.dart';
import 'package:my_app/model/product.model.dart';

class AllProductSearch {
  static String url = SVKey.searchProduct;

  static Future<List<Products>> fetchProductByCategoryName(
      String productName) async {
    final uri =
        Uri.parse(url).replace(queryParameters: {'productName': productName});
    final response = await http.get(uri);

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
