import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/features/details/productDetail.dart';
import 'package:my_app/model/product.model.dart';
import 'package:my_app/services/products/all-best-product.svc.dart';

class ListBestProduct extends StatefulWidget {
  const ListBestProduct({Key? key}) : super(key: key);

  @override
  _ListBestProduct createState() => _ListBestProduct();
}

class _ListBestProduct extends State<ListBestProduct> {
  List<Products> allBestProducts = [];

  @override
  void initState() {
    super.initState();

    AllBestProduct.fetchAllBestProducts().then((data) {
      setState(() {
        allBestProducts = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: allBestProducts.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return GestureDetector(
            onTap: () {
              // Navigate to product detail screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsDetailScreen(
                    productDetails: ProductDetails(
                      id: allBestProducts[itemIndex].id,
                      name: allBestProducts[itemIndex].productName,
                      imageUrl: allBestProducts[itemIndex].productImg,
                      price: allBestProducts[itemIndex].price.toDouble(),
                      description: allBestProducts[itemIndex].description,
                    ),
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                      allBestProducts[itemIndex].productImg.toString()),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 2,
                    offset: const Offset(3, 3),
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      bottom: 10.0,
                      left: 10.0,
                      child: Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.5),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Text(
                          allBestProducts[itemIndex].productName.toString(),
                          style: GoogleFonts.nunito(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  Positioned(
                      bottom: 10.0,
                      right: 10.0,
                      child: Text(
                        allBestProducts[itemIndex].price.toString(),
                        style: GoogleFonts.nunito(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
            ));
      },
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
    );
  }
}
