import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductWidget extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final double price;

  const ProductWidget({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(3, 3))
          ]),
      child: Column(
        children: [
          SizedBox(
              height: 140,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: Text(
                          'Loại đồ uống',
                          style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        ),
                      )),
                  const SizedBox(
                    width: 4,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: Text(
                          'Price',
                          style: GoogleFonts.nunito(
                              color: Colors.green,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      )),
                ],
              )),
          const SizedBox(
            width: 8,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(
                    textAlign: TextAlign.end,
                    productName,
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  )
                ],
              )),
          const SizedBox(
            width: 8,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                textAlign: TextAlign.start,
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w400, fontSize: 10),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    price.toString(),
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(Icons.add_circle_outline))
                ],
              ))
        ],
      ),
    );
  }
}
