import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/common/globs.dart';
import 'package:my_app/model/addressOrder.model.dart';

class AllAddressOrderService {
  static String url = SVKey.allAddressOrder;

  static Future<List<AddressOrder>> getAll(String userId) async {
    try {
      final response =
          await http.get(Uri.parse(url.replaceFirst(':userId', userId)));
      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        List<AddressOrder> addressOrderList = (decodedResponse['data'] as List)
            .map((data) => AddressOrder.fromJson(data))
            .toList();
        return addressOrderList;
      } else {
        throw Exception('Failed to load address order');
      }
    } catch (e) {
      print('Error AllAddressOrderService: $e');
      rethrow;
    }
  }

  static Future<AddressOrder> addNewAddressOrder(
      Map<String, dynamic> body) async {
    try {
      final response = await http.post(Uri.parse(SVKey.addAddressOrder),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        AddressOrder addressOrder =
            AddressOrder.fromJson(decodedResponse['data']);
        return addressOrder;
      } else {
        throw Exception('Failed to load address order');
      }
    } catch (e) {
      print('Error Add new address order: $e');
      rethrow;
    }
  }
}
