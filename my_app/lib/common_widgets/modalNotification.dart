import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModalNotification extends StatefulWidget {
  final String titleHeader;
  final String titleContent;
  const ModalNotification(
      {super.key, required this.titleHeader, required this.titleContent});

  @override
  State<ModalNotification> createState() => _ModalNotificationState();
}

class _ModalNotificationState extends State<ModalNotification> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16.0), // Set your desired radius here
      ),
      title: Text(widget.titleHeader,
          style: GoogleFonts.nunito(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
      content: Text(widget.titleContent,
          style: GoogleFonts.nunito(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)),
      actions: <Widget>[
        TextButton(
          child: Text('OK',
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
