import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/features/list/ListProductAddToCart.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('GIỎ HÀNG CỦA BẠN',
              style: GoogleFonts.nunito(
                  fontSize: 20, fontWeight: FontWeight.w400)),
        ),
        body: const ListProductAddToCart());
  }
}
