import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonIconWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onPressed;

  const ButtonIconWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      icon: Icon(icon),
      label: Text(
        title,
        style: GoogleFonts.nunito(fontSize: 18),
      ),
      onPressed: onPressed,
    );
  }
}
