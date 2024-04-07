import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/model/product.model.dart';

class AllProductRequest {
  static const String url =
      "http://192.168.255.1:3001/api/products?productType=656c2d6a9adeac3e5aaf5cc4&page=1&pageSize=12";

  static List<Products> parseProduct(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Products> products =
        list.map((model) => Products.fromJSON(model)).toList();
    return products;
  }

  static Future<List<Products>> fetchAllProducts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      final List<dynamic> productsData = jsonData['responseData']['products'];

      List<Products> products =
          productsData.map((json) => Products.fromJSON(json)).toList();

      return products;
    } else {
      throw Exception('Không thể lấy danh sách');
    }
  }
}
