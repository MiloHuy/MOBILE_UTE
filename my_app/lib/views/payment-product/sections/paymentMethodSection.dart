import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Phương thức thanh toán',
              style: GoogleFonts.nunito(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Container(
              width: 80,
              padding: const EdgeInsets.all(4.0), // Adjust padding as needed
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'COD',
                  style: GoogleFonts.nunito(
                    color: Colors.red,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
