import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/common/colors.com.dart';
import 'package:my_app/common_widgets/rounded_button.dart';
import 'package:my_app/views/login/login.view.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              "assets/images/welcome-v2.png",
              width: media.width,
            ),
            Positioned(
                top: media.height / 2 - 85,
                child: Image.asset("assets/images/logo.png",
                    width: media.width * 0.55,
                    height: media.height * 0.25,
                    fit: BoxFit.contain)),
          ],
        ),
        SizedBox(
          height: media.width * 0.1,
        ),
        Text(
          'Chào mừng quý khách đến với ứng dụng bán đồ uống của chúng tôi.',
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
              color: TColor.primaryText,
              fontWeight: FontWeight.w800,
              fontSize: 18),
        ),
        SizedBox(
          height: media.width * 0.1,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RoundedButton(
              title: 'Đăng nhập',
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginView()))
              },
            )),
        SizedBox(
          height: media.width * 0.08,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RoundedButton(
              title: 'Đăng ký tài khoản',
              onPressed: () => {},
            ))
      ],
    ));
  }
}
