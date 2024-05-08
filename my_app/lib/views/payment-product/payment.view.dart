import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/common_widgets/button_shadow.dart';
import 'package:my_app/main.dart';
import 'package:my_app/model/addressOrder.model.dart';
import 'package:my_app/model/productAddToCart.model.dart';
import 'package:my_app/services/orders/all-address-order.svc.dart';
import 'package:my_app/services/payment/paymentProduct.svc.dart';
import 'package:my_app/views/payment-product/sections/addressSections.dart';
import 'package:my_app/views/payment-product/sections/paymentMethodSection.dart';
import 'package:my_app/views/payment-product/sections/totalAmountSection.dart';
import 'package:my_app/widgets/product_cart_vertical_widget.dart';

class PaymentScreen extends StatefulWidget {
  final ProductAddToCart product;

  const PaymentScreen({Key? key, required this.product}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final userId = prefs?.getString('userId') ?? '';
  int productQuantity = 1;
  List<AddressOrder> allAddressOrders = [];

  int selectedAddressIndex = 0;

  void handleAddressIndexChanged(int index) {
    setState(() {
      selectedAddressIndex = index;
    });
  }

  Future<void> paymentProduct() async {
    PaymentProduct.postRequest(
      {
        "userId": userId,
        "productId": widget.product.id,
        "brandId": widget.product.brandId,
        "productPrice": widget.product.price[0] * productQuantity,
        "productQuanitiOrder": productQuantity,
        "productSize": widget.product.size[0],
        "receiverName": allAddressOrders[selectedAddressIndex].receiverName,
        "phone": allAddressOrders[selectedAddressIndex].phone,
        "addressOrder": allAddressOrders[selectedAddressIndex].addressOrder,
      },
    ).then((value) {
      print('Value: $value');
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
            content: Text('Thanh toán thành công',
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

  void fetchAllAddressOrders() async {
    AllAddressOrderService.getAll(userId).then((data) {
      setState(() {
        allAddressOrders = data;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAllAddressOrders();
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
          ProductCard(
            quantity: productQuantity,
            product: widget.product,
            price: widget.product.price[0],
            onChangedQuantity: (quantity) {
              setState(() {
                productQuantity = quantity;
              });
            },
          ),
          AddressSection(
              allAddressOrders: allAddressOrders,
              handleAddressIndexChanged: handleAddressIndexChanged),
          const PaymentMethodSection(),
          TotalAmountSection(
            totalAmount: widget.product.price[0] * productQuantity,
          ),
          const SizedBox(height: 20),
          PaymentButton(
            onPressed: paymentProduct,
          ),
        ],
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PaymentButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ButtonShadowWidget(
          title: 'THANH TOÁN',
          onPressed: onPressed,
          color: Colors.red,
        ));
  }
}
