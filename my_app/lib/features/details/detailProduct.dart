import 'package:flutter/material.dart';
import 'package:my_app/features/details/productDetail.dart';
import 'package:my_app/features/details/widgets/addto_cart.dart';
import 'package:my_app/features/details/widgets/description.dart';
import 'package:my_app/features/details/widgets/detail_app_bar.dart';
import 'package:my_app/features/details/widgets/image_slider.dart';
import 'package:my_app/features/details/widgets/items_details.dart';

class DetailScreen extends StatefulWidget {
  final ProductDetails product;
  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int currentImage = 0;
  int currentColor = 1;
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      floatingActionButton: AddToCartView(
        product: widget.product,
        quantity: currentIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailAppBar(
              product: widget.product,
            ),
            MyImageSlider(
              image: widget.product
                  .imageUrl, // this is the image url from the product model
              onChange: (index) {
                setState(() {
                  currentImage = index;
                });
              },
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemsDetails(product: widget.product),
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      const Text(
                        "Kích cỡ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(width: 20),
                      Row(
                        children: List.generate(
                          widget.product.size.length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                currentColor = index;
                              });
                            },
                            child: Text(
                              widget.product.size[index],
                              style: TextStyle(
                                fontSize: 18,
                                color: currentColor == index
                                    ? const Color(0xffff660e)
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: <Widget>[
                      const Text(
                        "Số lượng",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (currentIndex != 1) {
                                  setState(() {
                                    currentIndex--;
                                  });
                                }
                              },
                              iconSize: 18,
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              currentIndex.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 5),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  currentIndex++;
                                });
                              },
                              iconSize: 18,
                              icon: const Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  // for description
                  Description(
                    description: widget.product.description,
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
