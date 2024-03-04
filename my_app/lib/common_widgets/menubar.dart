import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuBarItem extends StatefulWidget {
  final String title;

  const MenuBarItem({Key? key, required this.title}) : super(key: key);

  @override
  State<MenuBarItem> createState() => _MenuBarItemState();
}

class _MenuBarItemState extends State<MenuBarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            print('Selected: ${widget.title}');
          },
          child: Text(
            widget.title,
            style: GoogleFonts.quicksand(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              decoration:
                  _isHovered ? TextDecoration.underline : TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
