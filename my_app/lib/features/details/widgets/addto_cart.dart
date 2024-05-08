import 'package:flutter/material.dart';
import 'package:my_app/common_widgets/button_shadow.dart';
import 'package:my_app/common_widgets/modalNotification.dart';
import 'package:my_app/features/details/productDetail.dart';
import 'package:my_app/main.dart';
import 'package:my_app/model/productAddToCart.model.dart';
import 'package:my_app/services/orders/addToCart.svc.dart';
import 'package:my_app/views/payment-product/payment.view.dart';

class AddToCartView extends StatefulWidget {
  final ProductDetails product;
  final int quantity;

  const AddToCartView(
      {super.key, required this.product, required this.quantity});

  @override
  State<AddToCartView> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCartView> {
  int currentIndex = 1;
  final userId = prefs?.getString('userId') ?? '';
  bool _isLoading = false;
  String? selectedSize;

  Future<void> addToCart() async {
    setState(() {
      _isLoading = true;
    });
    AddToCart.postRequest(
      {
        "userId": userId,
        "productId": widget.product.id,
        "productPrice": widget.product.price[0] * widget.quantity,
        "productQuanitiOrder": widget.quantity,
        "productSize": widget.product.size,
      },
    ).then((value) {
      print('value: $value');
      setState(() {
        _isLoading = false;
      });
      if (value['code'] == 404) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ModalNotification(
              titleHeader: 'Thông báo',
              titleContent: value['message'][0],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ModalNotification(
              titleHeader: 'Thông báo',
              titleContent: 'Thêm vào giỏ hàng thành công.',
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 1),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              child: ButtonShadowWidget(
                icon: Icons.shopping_cart,
                title: 'Add to Cart',
                color: Colors.green,
                onPressed: addToCart,
              ),
            ),
            const SizedBox(width: 10), // Add some space between the buttons
            Expanded(
              child: ButtonShadowWidget(
                icon: Icons.payment,
                title: 'Thanh toán',
                color: Colors.red,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        product: ProductAddToCart(
                          id: widget.product.id,
                          productName: widget.product.name,
                          price: widget.product.price,
                          size: widget.product.size,
                          description: widget.product.description,
                          productImg: widget.product.imageUrl,
                          brandId: widget.product.brandId,
                          isLiked: false,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
