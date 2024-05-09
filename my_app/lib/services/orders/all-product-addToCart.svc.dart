import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/common/globs.dart';
import 'package:my_app/model/productAddToCart.model.dart';

class AllProductAddToCart {
  static String url = SVKey.productOrderStatus;
  static String urlDelete = SVKey.deleteProduct;

  static Future<ProductAddToCartRes> getAll(
      Map<String, dynamic> body, String userId) async {
    try {
      var response = await http.post(
        Uri.parse(url.replaceFirst(':userId', userId)),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final productAddToCartRes = ProductAddToCartRes.fromJson(jsonData);

        return productAddToCartRes;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error AllProductAddToCart: $e');
      rethrow;
    }
  }

  static Future<dynamic> deleteProduct(String productId, String orderId) async {
    try {
      var response = await http.delete(
          Uri.parse(urlDelete.replaceFirst(':orderId', orderId)),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'productId': productId,
          }));

      if (response.statusCode == 200) {
        return jsonEncode(response.body);
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      print('Error deleteProduct: $e');
      rethrow;
    }
  }
}
