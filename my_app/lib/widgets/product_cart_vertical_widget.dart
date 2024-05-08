import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/model/productAddToCart.model.dart';
import 'package:my_app/utils/format.utils.dart';

class ProductCard extends StatefulWidget {
  final ProductAddToCart product;
  final int price;
  final int quantity;
  final Function(int)? onChangedQuantity;

  const ProductCard(
      {Key? key,
      required this.product,
      required this.price,
      required this.quantity,
      this.onChangedQuantity})
      : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int initQuanity = 0;

  @override
  void initState() {
    super.initState();
    initQuanity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130, // Set the height you want here
      child: Card(
        color: Colors.white,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
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
                    widget.product.productImg,
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
                      Text(widget.product.productName,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.quicksand(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 5),
                      Text('Size: ${widget.product.size[0].toString()}',
                          style: GoogleFonts.quicksand(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment:
                            CrossAxisAlignment.center, // Add this line
                        children: <Widget>[
                          Text(' ${formatNumber(widget.price)}Đ',
                              style: GoogleFonts.quicksand(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (widget.quantity > 0) {
                                      initQuanity--;
                                      widget.onChangedQuantity!(initQuanity);
                                    }
                                  });
                                },
                              ),
                              Text(
                                '$initQuanity',
                                style: const TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    initQuanity++;
                                    widget.onChangedQuantity!(initQuanity);
                                  });
                                },
                              ),
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
