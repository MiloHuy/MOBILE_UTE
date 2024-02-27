import 'package:flutter/material.dart';
import 'package:my_app/common/colors.com.dart';
import 'package:my_app/common/extension.dart';
import 'package:my_app/common/globs.dart';
import 'package:my_app/common/service_call.dart';
import 'package:my_app/common_widgets/rounded_button.dart';
import 'package:my_app/views/onBoard/on-board.view.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class OTPView extends StatefulWidget {
  final String email;
  const OTPView({super.key, required this.email});

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  String code = "";

  void btnSubmit() {
    if (code.length != 6) {
      mdShowAlert(Globs.appName, MSG.enterCode, () {});
      return;
    }

    endEditing();

    serviceCallForgotVerify({"email": widget.email, "otpCode": code});
  }

  void serviceCallForgotVerify(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(parameter, SVKey.svForgotPasswordVerify,
        withSuccess: (responseObj) async {
      Globs.hideHUD();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OnBoardingView()));
    }, failure: (err) async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OnBoardingView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 64,
              ),
              Text(
                "Chúng tôi đã gửi OTP qua mail",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Làm ở kiểm tra ở ${widget.email}\ncontinue để lấy lại mật khẩu",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                height: 60,
                child: OtpPinField(
                    key: _otpPinFieldController,
                    autoFillEnable: true,

                    ///for Ios it is not needed as the SMS autofill is provided by default, but not for Android, that's where this key is useful.
                    textInputAction: TextInputAction.done,

                    ///in case you want to change the action of keyboard
                    /// to clear the Otp pin Controller
                    onSubmit: (newCode) {
                      code = newCode;
                      btnSubmit();

                      /// return the entered pin
                    },
                    onChange: (newCode) {
                      code = newCode;

                      /// return the entered pin
                    },
                    onCodeChanged: (newCode) {
                      code = newCode;
                    },
                    fieldWidth: 40,

                    /// to decorate your Otp_Pin_Field
                    otpPinFieldStyle: OtpPinFieldStyle(

                        /// border color for inactive/unfocused Otp_Pin_Field
                        defaultFieldBorderColor: Colors.transparent,

                        /// border color for active/focused Otp_Pin_Field
                        activeFieldBorderColor: Colors.transparent,

                        /// Background Color for inactive/unfocused Otp_Pin_Field
                        defaultFieldBackgroundColor: TColor.textfield,
                        activeFieldBackgroundColor: TColor.textfield

                        /// Background Color for active/focused Otp_Pin_Field
                        ),
                    maxLength: 6,

                    /// no of pin field
                    showCursor: true,

                    /// bool to show cursor in pin field or not
                    cursorColor: TColor.placeholder,

                    /// to choose cursor color
                    upperChild: const Column(
                      children: [
                        SizedBox(height: 30),
                        Icon(Icons.flutter_dash_outlined, size: 150),
                        SizedBox(height: 20),
                      ],
                    ),
                    showCustomKeyboard: false,
                    cursorWidth: 3,
                    mainAxisAlignment: MainAxisAlignment.center,
                    otpPinFieldDecoration:
                        OtpPinFieldDecoration.defaultPinBoxDecoration),
              ),
              const SizedBox(
                height: 30,
              ),
              RoundedButton(
                  title: "Next",
                  onPressed: () {
                    btnSubmit();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
