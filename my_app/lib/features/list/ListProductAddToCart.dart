import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/main.dart';
import 'package:my_app/model/productAddToCart.model.dart';
import 'package:my_app/services/orders/all-product-addToCart.svc.dart';
import 'package:my_app/widgets/product_cart_vertical_widget.dart';

class ListProductAddToCart extends StatefulWidget {
  const ListProductAddToCart({super.key});

  @override
  State<ListProductAddToCart> createState() => _ListProductAddToCartState();
}

class _ListProductAddToCartState extends State<ListProductAddToCart> {
  List<ProductAddToCart> allProducts = [];
  List<int> productPrice = [];
  final userId = prefs?.getString('userId') ?? '';
  int price = 10; // Initial price

  @override
  void initState() {
    super.initState();

    AllProductAddToCart.getAll({"status": "NOT_ORDER"}, userId).then((value) {
      setState(() {
        allProducts = value.products;
        productPrice = value.productPrice;
      });
      // print('All Products: $allProducts');
    }).catchError((error) {
      print('Error getting all products: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productPrice.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(index.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ProductCard(
                    product: allProducts[index],
                    price: productPrice[index],
                  ),
                  onDismissed: (direction) {
                    // Handle dismissal
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng đơn hàng: ${productPrice.isNotEmpty ? productPrice.reduce((a, b) => a + b) : 0}',
                style: GoogleFonts.nunito(fontSize: 18, color: Colors.black),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle payment
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Thanh toán',
                    style:
                        GoogleFonts.nunito(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
