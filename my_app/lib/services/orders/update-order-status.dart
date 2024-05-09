import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/common/globs.dart';

class UpdateOrderStatus {
  static String url = SVKey.updateOrderStatus;

  static Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      Globs.showHUD();
      final response = await http.post(
        Uri.parse(url.replaceFirst(':orderID', orderId)),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'status': status,
        }),
      );

      if (response.statusCode == 200) {
        Globs.hideHUD();
        return jsonDecode(response.body);
      } else {
        Globs.hideHUD();
        throw Exception('Failed to update order status');
      }
    } catch (e) {
      Globs.hideHUD();
      throw Exception('Failed to update order status');
    }
  }
}
