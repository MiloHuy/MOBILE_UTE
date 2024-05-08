import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/common_widgets/input_chip.dart';
import 'package:my_app/features/list/ListBestProduct.dart';
import 'package:my_app/features/list/ListProducts.dart';
import 'package:my_app/main.dart';
import 'package:my_app/model/product.model.dart';
import 'package:my_app/services/products/productByCategoryName.svc.dart';
import 'package:my_app/services/products/search-product.svc.dart';
import 'package:my_app/views/login/login.view.dart';
import 'package:my_app/views/profile/profile.view.dart';
import 'package:rxdart/rxdart.dart';

class OnBoardingView extends StatefulWidget {
  final bool isLogin;
  const OnBoardingView({Key? key, this.isLogin = false}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  List<Products> allProducts = [];
  final TextEditingController _searchController = TextEditingController();
  final BehaviorSubject<String> _searchQuery = BehaviorSubject<String>();

  @override
  void initState() {
    super.initState();

    AllProductByCategoryName.fetchProductByCategoryName('CAFE').then((data) {
      setState(() {
        allProducts = data;
      });
    });

    _searchQuery.stream
        .debounceTime(const Duration(milliseconds: 500))
        .listen((query) {
      AllProductSearch.fetchProductByCategoryName(query)
          .then((value) => setState(() {
                allProducts = value;
              }));
    });
  }

  @override
  void dispose() {
    _searchQuery.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    final avatarUrl = prefs?.getString('avatar') ?? '';
    final email = prefs?.getString('email') ?? '';
    final fullName = prefs?.getString('fullName') ?? '';
    final phone = prefs?.getString('phone') ?? '';

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
                  border:
                      widget.isLogin ? null : Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: widget.isLogin
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(avatarUrl),
                      )
                    : Text('Login',
                        style: GoogleFonts.nunito(color: Colors.black)),
              ),
              onPressed: () {
                // Navigate to the login page
                widget.isLogin
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileView(
                                  avatarUrl: avatarUrl,
                                  email: email,
                                  name: fullName,
                                  phone: phone,
                                )))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()),
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
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: GoogleFonts.nunito(),
                    icon: const Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    _searchQuery.add(value);
                  },
                ),
              ),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 20,
                children: <Widget>[
                  InputChipWidget(
                    label: Text('CAFE',
                        style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                    isSelected: false, // replace with your logic
                    onSelected: (bool value) {
                      AllProductByCategoryName.fetchProductByCategoryName(
                              'CAFE')
                          .then((data) {
                        setState(() {
                          allProducts = data;
                        });
                      });
                    },
                  ),
                  InputChipWidget(
                    label: Text('TEA',
                        style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                    isSelected: false, // replace with your logic
                    onSelected: (bool value) {
                      AllProductByCategoryName.fetchProductByCategoryName('TEA')
                          .then((data) {
                        setState(() {
                          allProducts = data;
                        });
                      });
                    },
                  ),
                  InputChipWidget(
                    label: Text('JUICE',
                        style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                    isSelected: false, // replace with your logic
                    onSelected: (bool value) {
                      AllProductByCategoryName.fetchProductByCategoryName(
                              'JUICE')
                          .then((data) {
                        setState(() {
                          allProducts = data;
                        });
                      });
                    },
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Other widgets
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text('NHỮNG SẢN PHẨM NỔI BẬT',
                          style: GoogleFonts.nunito(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.black)),
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
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListProducts(
                              allProductsData: allProducts,
                            )),
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
