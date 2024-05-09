import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/model/order.model.dart';
import 'package:my_app/utils/format.utils.dart';

class ProductCardWidget extends StatelessWidget {
  final Orders product;
  final Widget buttonFunction;

  const ProductCardWidget(
      {super.key, required this.product, required this.buttonFunction});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(10), // adjust the radius as needed
              child: Image.network(
                product.productImg,
                width: 120,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(product.productName,
                      style: GoogleFonts.nunito(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Số lượng đặt: ${product.productQuanitiOrder}',
                      style: GoogleFonts.nunito(
                          fontSize: 14, fontWeight: FontWeight.w300)),
                  Text('Giá: ${formatNumber(product.productPrice)}',
                      style: GoogleFonts.nunito(
                          fontSize: 14, fontWeight: FontWeight.w300)),
                  Text('Kích thước: ${product.productSize[0]}',
                      style: GoogleFonts.nunito(
                          fontSize: 14, fontWeight: FontWeight.w300)),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(child: buttonFunction)
          ],
        ),
      ),
    );
  }
}
