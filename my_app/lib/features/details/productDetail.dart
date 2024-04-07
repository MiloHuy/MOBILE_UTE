import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetails {
  final String name;
  final String imageUrl;
  final double price;
  final String description;

  ProductDetails(
      {required this.name,
      required this.imageUrl,
      required this.price,
      required this.description});
}

class ProductDetailsDetailScreen extends StatefulWidget {
  final ProductDetails productDetails;

  const ProductDetailsDetailScreen({super.key, required this.productDetails});

  @override
  _ProductDetailsDetailScreenState createState() =>
      _ProductDetailsDetailScreenState();
}

class _ProductDetailsDetailScreenState
    extends State<ProductDetailsDetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết sản phẩm',
          style: GoogleFonts.nunito(fontSize: 25),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.network(
                    widget.productDetails.imageUrl,
                    height: media.height / 2,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(widget.productDetails.name,
                            style: GoogleFonts.nunito(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.remove),
                              color: Colors.black,
                              onPressed: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity--;
                                  }
                                });
                              },
                            ),
                            Text(
                              '$quantity',
                              style: GoogleFonts.nunito(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              color: Colors.black,
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Giá: ${widget.productDetails.price}',
                      style: GoogleFonts.nunito(fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Mô tả: ${widget.productDetails.description}',
                      style: GoogleFonts.nunito(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tổng tiền: ${widget.productDetails.price * quantity}',
                      style: GoogleFonts.nunito(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              icon: const Icon(Icons.shopping_cart),
              label: Text(
                'Add to Cart',
                style: GoogleFonts.nunito(fontSize: 20),
              ),
              onPressed: () {
                // Add your add to cart logic here
              },
            ),
          ),
        ],
      ),
    );
  }
}
