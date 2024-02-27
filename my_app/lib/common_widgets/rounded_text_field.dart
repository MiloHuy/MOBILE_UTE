import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/common/colors.com.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final double borderInput;
  final Widget? icon;

  const RoundedTextField(
      {super.key,
      this.controller,
      required this.hintText,
      this.keyboardType,
      this.obscureText = false,
      this.borderInput = 15,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: TColor.textfield,
          borderRadius: BorderRadius.circular(borderInput)),
      child: TextField(
        autocorrect: false,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20),
            // enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                width: 10,
                style: BorderStyle.none,
              ),
            ),
            prefixIcon: icon,
            hintText: hintText,
            hintStyle: GoogleFonts.nunito(
                color: TColor.placeholder,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}
