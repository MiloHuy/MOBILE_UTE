import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:my_app/main.dart';

class Globs {
  static const appName = "Beverage Order";

  static const userPayload = "user_payload";
  static const userLogin = "user_login";

  static void showHUD({String status = "loading ....."}) async {
    await Future.delayed(const Duration(milliseconds: 1));
    EasyLoading.show(status: status);
  }

  static void hideHUD() {
    EasyLoading.dismiss();
  }

  static void udSet(dynamic data, String key) {
    var jsonStr = json.encode(data);
    prefs?.setString(key, jsonStr);
  }

  static void udStringSet(String data, String key) {
    prefs?.setString(key, data);
  }

  static void udBoolSet(bool data, String key) {
    prefs?.setBool(key, data);
  }

  static void udStringToken(String key, String value) {
    prefs?.setString(key, value);
  }

  static void udIntSet(int data, String key) {
    prefs?.setInt(key, data);
  }

  static void udDoubleSet(double data, String key) {
    prefs?.setDouble(key, data);
  }

  static dynamic udValue(String key) {
    return json.decode(prefs?.get(key) as String? ?? "{}");
  }

  static String udValueString(String key) {
    return prefs?.get(key) as String? ?? "";
  }

  static bool udValueBool(String key) {
    return prefs?.get(key) as bool? ?? false;
  }

  static bool udValueTrueBool(String key) {
    return prefs?.get(key) as bool? ?? true;
  }

  static int udValueInt(String key) {
    return prefs?.get(key) as int? ?? 0;
  }

  static double udValueDouble(String key) {
    return prefs?.get(key) as double? ?? 0.0;
  }

  static void udRemove(String key) {
    prefs?.remove(key);
  }

  static Future<String> timeZone() async {
    try {
      return await FlutterTimezone.getLocalTimezone();
    } on PlatformException {
      return "";
    }
  }
}

class SVKey {
  static const mainUrl = "http://192.168.255.1:4001";
  static const baseUrl = '$mainUrl/api';
  static const nodeUrl = mainUrl;

  static const login = '$baseUrl/auth/login';
  static const svSignUp = '$baseUrl/auth/register';
  static const svForgotPasswordRequest = '$baseUrl/auth/forgot-password/';
  static const svForgotPasswordVerify = '$baseUrl/auth/verify-otp';
  static const svForgotPasswordSetNew = '${baseUrl}forgot_password_set_new';

  static const getAllProducts = '$baseUrl/products/all';
  static const getProductByCategory = '$baseUrl/filter/product/:categoryName';
  static const getAllBestProducts = '$baseUrl/product/bestSeller';
  static const searchProduct = '$baseUrl/products/search';
  static const addToCart = '$baseUrl/product/addToCart';
}

class KKey {
  static const id = '_id';
  static const code = "code";
  static const payload = "payload";
  static const status = "status";
  static const message = "message";
  static const phone = "phone";
  static const authToken = "auth_token";
  static const fullName = "fullName";
  static const email = "email";
  static const avatar = "avatar";
  static const mobile = "mobile";
  static const address = "address";
  static const userId = "user_id";
  static const resetCode = "reset_code";
}

class MSG {
  static const enterEmail = "Vui lòng nhập địa chỉ email phù hợp.";
  static const enterName = "Vui lòng nhập tên.";
  static const enterCode = "Please enter valid reset code.";
  static const enterGender = "Vui lòng nhập giới tính";

  static const enterMobile = "Vui lòng nhập tối thiểu 10 số.";
  static const enterAddress = "Please enter your address.";
  static const enterPassword =
      "Please enter password minimum 6 characters at least.";
  static const enterPasswordNotMatch = "Please enter password not match.";
  static const success = "success";
  static const fail = "fail";
}
