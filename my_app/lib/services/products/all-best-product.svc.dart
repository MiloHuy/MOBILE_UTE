import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/common/globs.dart';
import 'package:my_app/model/product.model.dart';

class AllBestProduct {
  static const String urlApi = SVKey.getAllProducts;

  static List<Products> parseProduct(String responseBody) {
    var list = json.decode(responseBody) as List<Products>;
    List<Products> products = list
        .map((model) => Products.fromJSON(model as Map<String, dynamic>))
        .toList();
    return products;
  }

  static Future<List<Products>> fetchAllBestProducts() async {
    var response = await http.get(Uri.parse(urlApi));

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
