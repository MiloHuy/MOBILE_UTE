import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/common/globs.dart';

class PaymentProduct {
  static String urlApi = SVKey.paymentProduct;

  static Future<Map<String, dynamic>> postRequest(
      Map<String, dynamic> body) async {
    try {
      var response = await http.post(
        Uri.parse(urlApi),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('err: $e');
      throw Exception('Failed to load products');
    }
  }
}
