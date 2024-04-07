import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListBestProduct extends StatelessWidget {
  const ListBestProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return Container(
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: const DecorationImage(
              image: NetworkImage(
                  'https://i.pinimg.com/564x/de/70/e9/de70e97e57073ccc141876099df293ee.jpg'),
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
                            color: Colors.black.withOpacity(0.5), width: 1.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Text(
                      'Tên sản phẩm',
                      style: GoogleFonts.nunito(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              Positioned(
                  bottom: 10.0,
                  right: 10.0,
                  child: Text(
                    '100',
                    style: GoogleFonts.nunito(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
        );
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
