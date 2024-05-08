import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/services/products/react-product.svc.dart';
import 'package:my_app/utils/format.utils.dart';

class ProductWidgetView extends StatefulWidget {
  final String productId;
  final String imageUrl;
  final String productName;
  final List<int> price;
  final String description;
  final bool isLiked;

  const ProductWidgetView({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.description,
    required this.productId,
    this.isLiked = false,
  }) : super(key: key);

  @override
  State<ProductWidgetView> createState() => _ProductWidgetViewState();
}

class _ProductWidgetViewState extends State<ProductWidgetView> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();

    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(3, 3))
            ]),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                  aspectRatio: 1.1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(
                              'Loại đồ uống',
                              style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10),
                            ),
                          )),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(
                              'Price',
                              style: GoogleFonts.nunito(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                          )),
                    ],
                  )),
              const SizedBox(
                width: 8,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.productName,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                width: 8,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    textAlign: TextAlign.start,
                    widget.description,
                    maxLines: 2, // Limit the text to 2 lines
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w400, fontSize: 10),
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatNumber(int.parse('${widget.price[0]}')),
                        textAlign: TextAlign.start,
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      IconButton(
                          onPressed: () => {
                                ReactProduct.likeProduct(widget.productId)
                                    .then((value) => {
                                          setState(() {
                                            isLiked = !isLiked;
                                          })
                                        })
                              },
                          icon: Icon(
                            isLiked ? Entypo.heart : Entypo.heart_empty,
                            size: 20,
                            color: isLiked ? Colors.red : Colors.black,
                          ))
                    ],
                  ))
            ],
          ),
        ));
  }
}
