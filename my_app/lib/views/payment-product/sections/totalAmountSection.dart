import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/utils/format.utils.dart';

class TotalAmountSection extends StatelessWidget {
  final int totalAmount;

  const TotalAmountSection({Key? key, required this.totalAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Tổng số tiền phải trả:',
              style: GoogleFonts.nunito(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('${formatNumber(totalAmount)} Đ',
              style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.red)),
        ],
      ),
    );
  }
}
