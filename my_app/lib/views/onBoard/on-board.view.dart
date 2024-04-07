import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/features/list/ListBestProduct.dart';
import 'package:my_app/features/list/ListProducts.dart';
import 'package:my_app/model/product.model.dart';
import 'package:my_app/services/products/all-products.svc.dart';
import 'package:my_app/views/login/login.view.dart';

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

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Row(
            children: [
              Image.asset('assets/images/logo.png', scale: 14),
              const SizedBox(width: 8),
              Text(
                'BEVERAGE ORDER',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w600, fontSize: 20),
              )
            ],
          ),
          actions: [
            TextButton(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text('Login',
                    style: GoogleFonts.nunito(color: Colors.black)),
              ),
              onPressed: () {
                // Navigate to the login page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: GoogleFonts.nunito(),
                    icon: const Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 20,
                      children: <Widget>[
                        Chip(
                          label: Text('CAFE', style: GoogleFonts.nunito()),
                        ),
                        Chip(
                          label: Text('TEA', style: GoogleFonts.nunito()),
                        ),
                        Chip(
                          label: Text('JUICE', style: GoogleFonts.nunito()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Other widgets
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 5.0),
                      child: Text('NHỮNG SẢN PHẨM NỔI BẬT',
                          style: GoogleFonts.nunito(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.green)),
                    ),
                    Flexible(
                      child: SizedBox(
                        height:
                            media.height * 0.3, // adjust this value as needed
                        child: const ListBestProduct(),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        height: media.height, // adjust this value as needed
                        child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: ListProducts()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
