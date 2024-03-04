import 'package:flutter/material.dart';
import 'package:my_app/common/colors.com.dart';
import 'package:my_app/common_widgets/menubar.dart';
import 'package:my_app/model/product.model.dart';
import 'package:my_app/services/products/all-products.svc.dart';
import 'package:my_app/widgets/product_widgets.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  List<Products> allProducts = [];

  @override
  void initState() {
    super.initState();

    AllProductRequest.fetchAllProducts().then((data) {
      setState(() {
        allProducts = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: TColor.bgHeaderPrimary,
          height: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
              Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                width: 80,
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Container(
          color: Colors.yellow,
          height: 80,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MenuBarItem(title: 'Trà Sữa'),
              MenuBarItem(title: 'Cafe'),
              MenuBarItem(title: 'Trà'),
              MenuBarItem(title: 'Thức Uống'),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchAnchor(
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(5, (int index) {
                  final String item = 'Sản phẩm $index';
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        controller.closeView(item);
                      });
                    },
                  );
                });
              },
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  hintText: 'Nhập sản phẩm bạn muốn tìm',
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                );
              },
            )),
        GridView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0.5,
            mainAxisSpacing: 0.5,
          ),
          itemCount: allProducts.length,
          itemBuilder: (BuildContext context, int index) {
            final product = allProducts[index];
            print(product);
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.5),
                child: ProductWidget(
                    imageUrl: 'assets/images/product_1.jpg',
                    productName: product.name ?? '',
                    price: 30.000));
          },
        ),
      ],
    ));
  }
}
