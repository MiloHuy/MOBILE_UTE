import 'package:flutter/material.dart';
import 'package:my_app/features/details/productDetail.dart';
import 'package:my_app/widgets/product_widgets.dart';

class ListProducts extends StatelessWidget {
  const ListProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 5,
      ),
      itemCount: 10,
      itemBuilder: (context, int i) {
        return GestureDetector(
          onTap: () {
            // Navigate to product detail screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsDetailScreen(
                  productDetails: ProductDetails(
                    name: 'Cafe',
                    imageUrl:
                        'https://i.pinimg.com/564x/de/70/e9/de70e97e57073ccc141876099df293ee.jpg',
                    price: 100.000,
                    description: 'Product description',
                  ),
                ),
              ),
            );
          },
          child: const ProductWidget(
            imageUrl: 'assets/images/product_1.jpg',
            productName: 'Cafe',
            price: 100.000,
          ),
        );
      },
    );
  }
}
