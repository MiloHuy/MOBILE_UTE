import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/model/productAddToCart.model.dart';
import 'package:my_app/utils/format.utils.dart';

class ProductCard extends StatelessWidget {
  final ProductAddToCart product;
  final int price;

  const ProductCard({Key? key, required this.product, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130, // Set the height you want here
      child: Card(
        color: Colors.white,
        shadowColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.network(
                    product.productImg,
                    fit: BoxFit.fill,
                    height: 130, // Set the height you want here
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.productName,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.quicksand(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 5),
                      Text('Size: ${product.size[0].toString()}',
                          style: GoogleFonts.quicksand(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment:
                            CrossAxisAlignment.center, // Add this line
                        children: <Widget>[
                          Text(' ${formatNumber(price)}Đ',
                              style: GoogleFonts.quicksand(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          Row(
                            children: <Widget>[
                              IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    // Handle button press
                                  }),
                              const Text('10'),
                              IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    // Handle button press
                                  }),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
