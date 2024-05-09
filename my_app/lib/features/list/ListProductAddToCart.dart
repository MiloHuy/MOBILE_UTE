import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/common_widgets/button_shadow.dart';
import 'package:my_app/main.dart';
import 'package:my_app/model/order.model.dart';
import 'package:my_app/model/productAddToCart.model.dart';
import 'package:my_app/services/orders/all-product-addToCart.svc.dart';
import 'package:my_app/utils/format.utils.dart';
import 'package:my_app/widgets/product_card_widget.dart';

class ListProductAddToCart extends StatefulWidget {
  const ListProductAddToCart({super.key});

  @override
  State<ListProductAddToCart> createState() => _ListProductAddToCartState();
}

class _ListProductAddToCartState extends State<ListProductAddToCart> {
  List<ProductAddToCart> allProducts = [];
  List<int> productPrice = [];
  List<int> productQuanitiOrder = [];
  String orderId = '';

  final userId = prefs?.getString('userId') ?? '';
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();

    fetchAllProducts();
  }

  void fetchAllProducts() {
    AllProductAddToCart.getAll({"status": "NOT_ORDER"}, userId).then((value) {
      setState(() {
        allProducts = value.products;
        productPrice = value.productPrice;
        productQuanitiOrder = value.productQuanitiOrder;
        totalPrice = calculateTotalPrice();
        orderId = value.id;
      });
    }).catchError((error) {
      print('Error getting all products: $error');
    });
  }

  int calculateTotalPrice() {
    int total = 0;
    for (int i = 0; i < productPrice.length; i++) {
      total += productPrice[i] * productQuanitiOrder[i];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: productPrice.length,
              itemBuilder: (context, index) {
                if (index < productPrice.length && index < allProducts.length) {
                  final cartItems = allProducts[index];
                  return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.only(bottom: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300]!,
                              blurRadius: 0.5,
                              offset: const Offset(0, 3)),
                        ],
                      ),
                      child: ProductCardWidget(
                          product: Orders(
                              userId: userId,
                              productId: cartItems.id,
                              productImg: cartItems.productImg,
                              productName: cartItems.productName,
                              productPrice: cartItems.price[0],
                              productQuanitiOrder: 1,
                              productSize: cartItems.size),
                          buttonFunction: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  await AllProductAddToCart.deleteProduct(
                                      cartItems.id, orderId);
                                  fetchAllProducts();
                                },
                                child: const Icon(Icons.delete,
                                    color: Colors.red, size: 20),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey,
                                      width:
                                          0.5), // Customize color and width as needed
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        if (productQuanitiOrder[index] > 0) {
                                          setState(() {
                                            productQuanitiOrder[index]--;
                                            totalPrice = calculateTotalPrice();
                                          });
                                        }
                                      },
                                      child: const Icon(Icons.remove, size: 20),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      productQuanitiOrder[index].toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          productQuanitiOrder[index]++;
                                          totalPrice = calculateTotalPrice();
                                        });
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                              )
                            ],
                          )));
                }
                return null;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng đơn hàng: ${formatNumber(totalPrice)}',
                style: GoogleFonts.nunito(fontSize: 18, color: Colors.black),
              ),
              const SizedBox(width: 30),
              Expanded(
                  child: ButtonShadowWidget(
                title: 'Thanh toán',
                color: Colors.red,
                onPressed: () {},
              ))
            ],
          ),
        ],
      ),
    );
  }
}
