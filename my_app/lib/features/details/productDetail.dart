import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/common_widgets/button_icon.dart';
import 'package:my_app/common_widgets/modalNotification.dart';
import 'package:my_app/features/select/SelectSizeProduct.dart';
import 'package:my_app/main.dart';
import 'package:my_app/model/productAddToCart.model.dart';
import 'package:my_app/services/orders/addToCart.svc.dart';
import 'package:my_app/views/payment-product/payment.view.dart';

class ProductDetails {
  final String id;
  final String name;
  final String imageUrl;
  final List<int> price;
  final List<String> size;
  final String brandId;
  final String description;

  ProductDetails({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.brandId,
    required this.description,
    required this.size,
  });
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
        "productId": widget.productDetails.id,
        "productPrice": widget.productDetails.price[0] * quantity,
        "productQuanitiOrder": quantity,
        "productSize": widget.productDetails.size,
      },
    ).then((value) {
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
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết sản phẩm',
          style: GoogleFonts.nunito(fontSize: 25),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Add your cart logic here
            },
          ),
        ],
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
                        Expanded(
                          child: Text(widget.productDetails.name,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunito(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ),
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
                      'Giá: ${widget.productDetails.price.join(", ")}',
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Size: ',
                          style: GoogleFonts.nunito(fontSize: 20),
                        ),
                        const SizedBox(width: 10),
                        SelectSize(
                          sizes: widget.productDetails.size,
                          onSizeChanged: (String? value) {
                            // Handle size change here
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tổng tiền: ${widget.productDetails.price[0] * quantity}',
                      style: GoogleFonts.nunito(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ButtonIconWidget(
                    icon: Icons.shopping_cart,
                    title: 'Add to Cart',
                    color: Colors.green,
                    onPressed: addToCart,
                  ),
                ),
                const SizedBox(width: 10), // Add some space between the buttons
                Expanded(
                  child: ButtonIconWidget(
                    icon: Icons.payment,
                    title: 'Payment',
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                            product: ProductAddToCart(
                              id: widget.productDetails.id,
                              productName: widget.productDetails.name,
                              price: widget.productDetails.price,
                              size: widget.productDetails.size,
                              description: widget.productDetails.description,
                              productImg: widget.productDetails.imageUrl,
                              brandId: widget.productDetails.brandId,
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
        ],
      ),
    );
  }
}
