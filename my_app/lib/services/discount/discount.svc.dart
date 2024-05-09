import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/common/globs.dart';
import 'package:my_app/model/discount.model.dart';

class DiscountProduct {
  static String urlAll = SVKey.allDiscount;

  static Future<DiscountRes> getAll() async {
    try {
      var response = await http.get(
        Uri.parse(urlAll),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('jsonDecode(response.body) ${jsonDecode(response.body)}');
        return DiscountRes.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load discount');
      }
    } catch (e) {
      print('Error all discount: $e');
      rethrow;
    }
  }
}
