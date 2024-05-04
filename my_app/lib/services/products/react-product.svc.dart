import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/common/globs.dart';

class ReactProduct {
  static String url = SVKey.likeProduct;

  static Future<void> likeProduct(String productId) async {
    try {
      final uri = Uri.parse(url.replaceFirst(':productId', productId));
      final response = await http.post(uri);

      // print('Response: ${response.body}');

      if (response.statusCode == 200) {
        print('Product liked');
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to like product');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
