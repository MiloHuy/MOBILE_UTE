import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:my_app/utils/format.utils.dart';

class DiscountCard extends StatelessWidget {
  final String name;
  final int minValue;
  final String nameCode;
  final int maxValue;

  const DiscountCard({
    Key? key,
    required this.name,
    required this.minValue,
    required this.nameCode,
    required this.maxValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      height: 130,
      decoration: const BoxDecoration(
        border: DashedBorder(
          dashLength: 10,
          left: BorderSide(color: Colors.red, width: 2),
          top: BorderSide(color: Colors.red, width: 2),
          right: BorderSide(color: Colors.red, width: 2),
          bottom: BorderSide(color: Colors.red, width: 2),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Tên: $name',
              style: GoogleFonts.nunito(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            RichText(
              text: TextSpan(
                style: GoogleFonts.nunito(fontSize: 16),
                children: <TextSpan>[
                  const TextSpan(
                      text: 'Tối thiểu: ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  TextSpan(
                      text: '${formatNumber(minValue)} Đ',
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black)),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: GoogleFonts.nunito(fontSize: 16),
                children: <TextSpan>[
                  const TextSpan(
                      text: 'Mã Code: ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  TextSpan(
                      text: nameCode,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black)),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: GoogleFonts.nunito(fontSize: 16),
                children: <TextSpan>[
                  const TextSpan(
                      text: 'Tối đa: ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  TextSpan(
                      text: '$maxValue',
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
