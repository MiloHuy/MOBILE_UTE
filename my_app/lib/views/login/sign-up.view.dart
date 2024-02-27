import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/common/colors.com.dart';
import 'package:my_app/common/extension.dart';
import 'package:my_app/common/globs.dart';
import 'package:my_app/common/service_call.dart';
import 'package:my_app/common_widgets/rounded_button.dart';
import 'package:my_app/common_widgets/rounded_text_field.dart';
import 'package:my_app/views/login/login.view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassWord = TextEditingController();
  TextEditingController txtFullName = TextEditingController();
  TextEditingController txtGender = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtAddress = TextEditingController();

  void serviceCallRegister(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(parameter, SVKey.svSignUp,
        withSuccess: (responseObj) async {
      Globs.hideHUD();
      if (responseObj[KKey.status] == "Created") {
        Globs.udSet(responseObj[KKey.payload] as Map? ?? {}, Globs.userPayload);
        Globs.udBoolSet(true, Globs.userLogin);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginView(),
            ),
            (route) => false);
      } else {
        log(responseObj[KKey.message]);
        mdShowAlert(Globs.appName,
            responseObj[KKey.message] as String? ?? MSG.fail, () {});
      }
    }, failure: (err) async {
      Globs.hideHUD();
      mdShowAlert(Globs.appName, err.toString(), () {});
    });
  }

  void submitRegister() {
    if (!txtEmail.text.isEmail) {
      mdShowAlert(Globs.appName, MSG.enterEmail, () {});
      return;
    }

    if (txtPassWord.text.length < 6) {
      mdShowAlert(Globs.appName, MSG.enterPassword, () {});
      return;
    }

    if (txtFullName.text.isEmpty) {
      mdShowAlert(Globs.appName, MSG.enterName, () {});
      return;
    }

    if (txtGender.text.isEmpty) {
      mdShowAlert(Globs.appName, MSG.enterGender, () {});
      return;
    }

    if (txtPhone.text.isEmpty) {
      mdShowAlert(Globs.appName, MSG.enterMobile, () {});
      return;
    }

    endEditing();

    serviceCallRegister({
      "email": txtEmail.text,
      "password": txtPassWord.text,
      "fullName": txtFullName.text,
      "gender": txtGender.text,
      "phone": txtPhone.text,
      "address": txtAddress.text
    });
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
                  "Đăng ký",
                  style: GoogleFonts.nunito(
                      color: TColor.primaryText,
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 25),
                RoundedTextField(
                    hintText: 'Nhập email của bạn.',
                    controller: txtEmail,
                    keyboardType: TextInputType.emailAddress,
                    borderInput: 15,
                    icon: const Icon(Icons.phone_iphone_rounded)),
                const SizedBox(height: 25),
                RoundedTextField(
                    hintText: 'Nhập mật khẩu của bạn.',
                    controller: txtPassWord,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    borderInput: 15,
                    icon: const Icon(Icons.remove_red_eye_sharp)),
                const SizedBox(height: 25),
                RoundedTextField(
                    hintText: 'Họ và tên.',
                    controller: txtFullName,
                    keyboardType: TextInputType.emailAddress,
                    borderInput: 15,
                    icon: const Icon(Icons.format_color_text_rounded)),
                const SizedBox(height: 25),
                RoundedTextField(
                    hintText: 'Giới tính.',
                    controller: txtGender,
                    keyboardType: TextInputType.emailAddress,
                    borderInput: 15,
                    icon: const Icon(Icons.man)),
                const SizedBox(height: 25),
                RoundedTextField(
                    hintText: 'Số điện thoại.',
                    controller: txtPhone,
                    keyboardType: TextInputType.phone,
                    borderInput: 15,
                    icon: const Icon(Icons.phone_android_rounded)),
                const SizedBox(height: 25),
                RoundedTextField(
                    hintText: 'Địa chỉ.',
                    controller: txtAddress,
                    keyboardType: TextInputType.emailAddress,
                    borderInput: 15,
                    icon: const Icon(Icons.location_on_outlined)),
                const SizedBox(
                  height: 30,
                ),
                RoundedButton(
                    title: 'Đăng ký', onPressed: () => {submitRegister()}),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text('Quên mật khẩu?',
                        style: GoogleFonts.nunito(
                          color: TColor.secondaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ))),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()));
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Đăng nhập',
                            style: GoogleFonts.nunito(
                                color: TColor.primaryText,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ])),
              ],
            )),
      ),
    ));
  }
}
