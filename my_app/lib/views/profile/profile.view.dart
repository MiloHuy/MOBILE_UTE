import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/views/orders/cart.view.dart';
import 'package:my_app/views/profile/edit-profile.view.dart';

class ProfileView extends StatefulWidget {
  final String avatarUrl;
  final String email;
  final String name;
  final String phone;

  const ProfileView(
      {super.key,
      required this.avatarUrl,
      required this.email,
      required this.name,
      required this.phone});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Profile Settings', style: GoogleFonts.nunito(fontSize: 20)),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.avatarUrl),
                ),
                Text(widget.name, style: GoogleFonts.nunito(fontSize: 20)),
              ],
            ),
          ),
          Container(
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text('Thông tin cá nhân',
                  style: GoogleFonts.nunito(fontSize: 20)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditProfileView()),
                );
              },
            ),
          ),
          Container(
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: Text('Giỏ hàng', style: GoogleFonts.nunito(fontSize: 20)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartView(),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.local_offer),
              title:
                  Text('Mã giảm giá', style: GoogleFonts.nunito(fontSize: 20)),
              onTap: () {
                // Navigate to the Discount screen
              },
            ),
          ),
          Container(
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.blinds_closed_rounded),
              title: Text('Đơn hàng', style: GoogleFonts.nunito(fontSize: 20)),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
