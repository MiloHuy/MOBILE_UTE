import 'package:flutter/material.dart';
import 'package:my_app/features/details/detailProduct.dart';
import 'package:my_app/features/details/productDetail.dart';
import 'package:my_app/model/product.model.dart';
import 'package:my_app/widgets/product_widgets.dart';

class ListProducts extends StatefulWidget {
  final List<Products> allProductsData;

  const ListProducts({super.key, required this.allProductsData});

  @override
  State<ListProducts> createState() => _ListProducts();
}

class _ListProducts extends State<ListProducts> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 5,
      ),
      itemCount: widget.allProductsData.length,
      itemBuilder: (context, int i) {
        return GestureDetector(
          onTap: () {
            // Navigate to product detail screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  product: ProductDetails(
                    id: widget.allProductsData[i].id,
                    name: widget.allProductsData[i].productName,
                    imageUrl: widget.allProductsData[i].productImg,
                    price: widget.allProductsData[i].price,
                    description: widget.allProductsData[i].description,
                    size: widget.allProductsData[i].size,
                    brandId: widget.allProductsData[i].brandId,
                  ),
                ),
              ),
            );
          },
          child: ProductWidgetView(
            imageUrl: widget.allProductsData[i].productImg,
            productName: widget.allProductsData[i].productName,
            price: widget.allProductsData[i].price,
            description: widget.allProductsData[i].description,
            productId: widget.allProductsData[i].id,
            isLiked: widget.allProductsData[i].isLiked,
          ),
        );
      },
    );
  }
}
