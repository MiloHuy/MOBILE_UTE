import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/main.dart';
import 'package:my_app/model/order.model.dart';
import 'package:my_app/model/productAddToCart.model.dart';
import 'package:my_app/services/orders/all-product-status.svc.dart';
import 'package:my_app/services/orders/update-order-status.dart';
import 'package:my_app/widgets/product_card_widget.dart';

class MyOrderView extends StatefulWidget {
  const MyOrderView({Key? key}) : super(key: key);

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final userId = prefs?.getString('userId') ?? '';
  List<ProductAddToCart> allOrders = [];
  final StreamController<String> _streamController = StreamController<String>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var status in statuses) {
        fetchOrders(status);
      }
    });
  }

  Future<ProductAddToCartRes> fetchOrders(String status) {
    return AllProductStatusService.getAll({'status': status}, userId)
        .then((value) => value);
  }

  Widget buildOrders(String status) {
    return FutureBuilder<ProductAddToCartRes>(
      future: fetchOrders(status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
            'Error: ${snapshot.error}',
            style: GoogleFonts.nunito(fontSize: 15),
          ));
        } else if (snapshot.data!.products.isEmpty) {
          return Center(
            child: Text('Chưa có đơn hàng nào',
                style: GoogleFonts.nunito(fontSize: 15)),
          );
        } else {
          allOrders = snapshot.data!.products;
          return ListView.builder(
            itemCount: allOrders.length,
            itemBuilder: (context, index) {
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
                      productId: allOrders[index].id,
                      productName: allOrders[index].productName,
                      productPrice: allOrders[index].price.isNotEmpty
                          ? allOrders[index].price[0]
                          : 0,
                      productQuanitiOrder: allOrders[index].price.length,
                      productSize: allOrders[index].size,
                      productImg: allOrders[index].productImg,
                    ),
                    buttonFunction: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shadowColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          child: Text(
                            'Hủy đơn',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () async {
                            await UpdateOrderStatus.updateOrderStatus(
                              snapshot.data!.id,
                              'ABORTED',
                            ).then((value) => value);

                            _streamController.add(status);

                            setState(() {});
                          },
                        )),
                  ));
            },
          );
        }
      },
    );
  }

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Chờ xác nhận'),
    const Tab(text: 'Đang chuẩn bị'),
    const Tab(text: 'Đang vận chuyển'),
    const Tab(text: 'Đã giao'),
  ];

  final List<String> statuses = [
    "ORDERED",
    "PREPARING",
    "DELIVERING",
    "DELIVERED"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn hàng của tôi'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.zero,
            child: TabBar(
              controller: _tabController,
              tabs: myTabs,
              isScrollable: true,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: statuses.map((status) => buildOrders(status)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
