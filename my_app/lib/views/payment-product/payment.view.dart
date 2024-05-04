import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/main.dart';
import 'package:my_app/model/productAddToCart.model.dart';
import 'package:my_app/services/payment/paymentProduct.svc.dart';
import 'package:my_app/utils/format.utils.dart';
import 'package:my_app/widgets/product_cart_vertical_widget.dart';

class PaymentScreen extends StatefulWidget {
  final ProductAddToCart product;

  const PaymentScreen({Key? key, required this.product}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final userId = prefs?.getString('userId') ?? '';
  bool _isLoading = false;

  Future<void> paymentProduct() async {
    setState(() {
      _isLoading = true;
    });
    PaymentProduct.postRequest(
      {
        "userId": userId,
        "productId": [widget.product.id],
        "brandId": [widget.product.brandId],
        "productPrice": [widget.product.price[0]],
        "productQuanitiOrder": '1',
        "productSize": [widget.product.size[0]],
        "addressOrder": "123 Main Street, City, Country",
      },
    ).then((value) {
      print('Value: $value');
      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Success',
                style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black)),
            content: Text('User updated successfully',
                style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black)),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thanh toán',
          style: GoogleFonts.nunito(
              fontSize: 20, fontWeight: FontWeight.w300, color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ProductCard(product: widget.product, price: widget.product.price[0]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Địa chỉ',
                    style: GoogleFonts.nunito(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const Text('123 Main Street, City, Country'),
                const SizedBox(height: 20),
                Text('Phương thức thanh toán',
                    style: GoogleFonts.nunito(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const Text('COD', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20), // Thụt vào từ cả hai đầu
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(
                  width: 200), // Đặt chiều rộng của nút
              child: ElevatedButton(
                onPressed: () {
                  paymentProduct();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.transparent), // Đặt màu nền là trong suốt
                  side: MaterialStateProperty.all<BorderSide>(const BorderSide(
                      color: Colors.grey, width: 1)), // Đặt viền
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  elevation: MaterialStateProperty.all<double>(0),
                  shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Thanh toán ${formatNumber(widget.product.price[0])} Đ',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
