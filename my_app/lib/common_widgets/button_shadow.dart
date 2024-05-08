import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonShadowWidget extends StatefulWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color color;
  final IconData? icon;
  final double? heightButton;

  const ButtonShadowWidget({
    Key? key,
    this.onPressed,
    required this.title,
    required this.color,
    this.icon,
    this.heightButton,
  }) : super(key: key);

  @override
  _ButtonShadowWidgetState createState() => _ButtonShadowWidgetState();
}

class _ButtonShadowWidgetState extends State<ButtonShadowWidget> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _padding = 0;
        });
      },
      onTapUp: (_) {
        setState(() {
          _padding = 6;
        });
        widget.onPressed!();
      },
      child: AnimatedContainer(
        padding: EdgeInsets.only(bottom: _padding),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
            ),
          ],
        ),
        duration: const Duration(milliseconds: 100),
        child: Container(
            width: double.infinity,
            height: widget.heightButton ?? 50,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null)
                    Icon(
                      widget.icon,
                      color: Colors.white,
                    ),
                  const SizedBox(width: 10),
                  Text(
                    widget.title,
                    style:
                        GoogleFonts.nunito(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
