import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/common/colors.com.dart';
import 'package:my_app/common/extension.dart';
import 'package:my_app/common/globs.dart';
import 'package:my_app/common/service_call.dart';
import 'package:my_app/common_widgets/rounded_button.dart';
import 'package:my_app/common_widgets/rounded_text_field.dart';
import 'package:my_app/views/login/forgot-password.view.dart';
import 'package:my_app/views/login/sign-up.view.dart';
import 'package:my_app/views/onBoard/on-board.view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassWord = TextEditingController();

  void serviceCallLogin(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(parameter, SVKey.login, withSuccess: (responseObj) async {
      Globs.hideHUD();
      if (responseObj[KKey.status] == "OK") {
        Globs.udSet(responseObj[KKey.payload] as Map? ?? {}, Globs.userPayload);
        Globs.udBoolSet(true, Globs.userLogin);
        Globs.udStringToken(
            'token', responseObj['responseData']['accessToken']);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const OnBoardingView(),
            ),
            (route) => false);
        // await prefs?.setString('token', responseObj['accessToken']);
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

  void submitLogin() {
    if (!txtEmail.text.isEmail) {
      mdShowAlert(Globs.appName, MSG.enterEmail, () {});
      return;
    }

    if (txtPassWord.text.length < 6) {
      mdShowAlert(Globs.appName, MSG.enterPassword, () {});
      return;
    }

    endEditing();

    serviceCallLogin({
      "email": txtEmail.text,
      "password": txtPassWord.text,
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
                  "Đăng nhập",
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
                const SizedBox(height: 30),
                RoundedTextField(
                    hintText: 'Nhập mật khẩu của bạn.',
                    controller: txtPassWord,
                    keyboardType: TextInputType.emailAddress,
                    borderInput: 15,
                    obscureText: true,
                    icon: const Icon(Icons.remove_red_eye_sharp)),
                const SizedBox(
                  height: 30,
                ),
                RoundedButton(
                    title: 'Đăng nhập', onPressed: () => {submitLogin()}),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPassword()));
                    },
                    child: Text('Quên mật khẩu?',
                        style: GoogleFonts.nunito(
                          color: TColor.secondaryText,
                          fontSize: 20,
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
                              builder: (context) => const SignUpView()));
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Bạn chưa có tài khoản?',
                            style: GoogleFonts.nunito(
                                color: TColor.primaryText,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            ' Đăng ký',
                            style: GoogleFonts.nunito(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ])),
              ],
            )),
      ),
    ));
  }
}
