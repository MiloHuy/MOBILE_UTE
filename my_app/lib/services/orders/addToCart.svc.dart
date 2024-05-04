import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/common/globs.dart';

class AddToCart {
  static String url = SVKey.addToCart;

  static Future<Map<String, dynamic>> postRequest(
      Map<String, dynamic> body) async {
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // If the server returns an unexpected response, throw an exception.
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}