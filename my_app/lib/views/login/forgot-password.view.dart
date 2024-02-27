import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/common/colors.com.dart';
import 'package:my_app/common/extension.dart';
import 'package:my_app/common/globs.dart';
import 'package:my_app/common/service_call.dart';
import 'package:my_app/common_widgets/rounded_button.dart';
import 'package:my_app/common_widgets/rounded_text_field.dart';
import 'package:my_app/views/login/otp.view.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController txtEmail = TextEditingController();

  Future<void> sendPostRequest(String email) async {
    final Uri url =
        Uri.parse('http://192.168.255.1:3001/api/auth/forgot-password/');

    final Map<String, dynamic> data = {
      'email': email,
      // Add other parameters here
    };

    try {
      Globs.showHUD();
      final http.Response response = await http.post(
        url,
        body: jsonEncode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      Globs.hideHUD();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => OTPView(email: txtEmail.text),
          ),
          (route) => false);
    } catch (e) {
      // Handle exceptions
    }
  }

  void serviceCallForgotPassword(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(parameter, SVKey.svForgotPasswordRequest,
        withSuccess: (responseObj) async {
      Globs.hideHUD();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => OTPView(email: txtEmail.text),
          ),
          (route) => false);
    }, failure: (err) async {
      Globs.hideHUD();
      mdShowAlert(Globs.appName, err.toString(), () {});
    });
  }

  void submitForgotPassword() {
    if (!txtEmail.text.isEmail) {
      mdShowAlert(Globs.appName, MSG.enterEmail, () {});
      return;
    }

    endEditing();

    serviceCallForgotPassword({"email": txtEmail.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Text(
                  "Quên mật khẩu",
                  style: GoogleFonts.nunito(
                      color: TColor.primaryText,
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 30),
                RoundedTextField(
                    hintText: 'Nhập email của bạn.',
                    controller: txtEmail,
                    keyboardType: TextInputType.emailAddress,
                    borderInput: 15,
                    icon: const Icon(Icons.email_outlined)),
                const SizedBox(
                  height: 30,
                ),
                RoundedButton(
                    title: 'Tiếp theo',
                    onPressed: () => {submitForgotPassword()}),
                SizedBox(
                  height: 15,
                  child: TextButton(
                      onPressed: () {},
                      child: Text('Đăng nhập',
                          style: GoogleFonts.nunito(
                            color: TColor.secondaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ))),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            )),
      ),
    ));
  }
}
