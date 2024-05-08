import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/common/globs.dart';
import 'package:my_app/model/productAddToCart.model.dart';

class AllProductStatusService {
  static String url = SVKey.productOrderStatus;

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
      print('Error AllProductStatusService: $e');
      rethrow;
    }
  }
}
