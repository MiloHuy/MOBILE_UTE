import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/features/details/productDetail.dart';
import 'package:my_app/utils/format.utils.dart';

class ItemsDetails extends StatelessWidget {
  final ProductDetails product;
  const ItemsDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${formatNumber(product.price[0])} Đ",
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                // for rating
                Row(
                  children: [
                    Container(
                      width: 55,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xffff660e),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 15,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '5',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: "Người bán: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextSpan(
                    text: 'UTE Coffee',
                    style: GoogleFonts.nunito(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
