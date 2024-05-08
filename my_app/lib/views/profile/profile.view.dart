import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/common/colors.com.dart';
import 'package:my_app/common/setting_row.dart';
import 'package:my_app/common_widgets/button_shadow.dart';
import 'package:my_app/views/orders/cart.view.dart';
import 'package:my_app/views/orders/my_order.view.dart';
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
  List accountArr = [
    {
      "image":
          "https://firebasestorage.googleapis.com/v0/b/mobileute-acf54.appspot.com/o/UserDefault.jpg?alt=media&amp;token=7db2c405-1349-453c-8e18-5897e850979c",
      "name": "Chỉnh sửa thông tin",
      "tag": "1",
      "onPress": const EditProfileView()
    },
  ];

  List orderArr = [
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIJsBCkc2j0Q3g83Yc-isvPYR4w_sR0ZY3ZLO2l3wLQQ&s",
      "name": "Đơn hàng của tôi",
      "tag": "4",
      "onPress": const MyOrderView()
    },
    {
      "image":
          "https://static.vecteezy.com/system/resources/thumbnails/007/126/787/small/star-icon-vector.jpg",
      "name": "Đánh giá",
      "tag": "5"
    },
    {
      "image": "https://static.thenounproject.com/png/1700366-200.png",
      "name": "Giỏ hàng",
      "tag": "6",
      "onPress": const CartView()
    },
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ32-rDyWsWk19V7AynIAix4nxzYMAEWo1OzzZbDgignQ&s",
      "name": "Phiếu giảm giá",
      "tag": "7"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Profile Settings', style: GoogleFonts.nunito(fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProfileRow(),
              const SizedBox(height: 25),
              _buildSection('Tài khoản', accountArr),
              const SizedBox(height: 25),
              _buildSection('Đơn hàng', orderArr),
              const SizedBox(height: 20),
              _buildLogoutButton(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileRow() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(widget.avatarUrl),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.name,
                style: GoogleFonts.nunito(
                    fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 5),
            Text(widget.phone,
                style: GoogleFonts.nunito(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _buildSection(String title, List items) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  _buildItem(item),
                  const Divider(color: Colors.grey),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildItem(Map item) {
    return SettingRow(
      icon: item['image'],
      title: item['name'],
      number: 6,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => item['onPress']),
        );
      },
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: ButtonShadowWidget(
          title: 'Logout',
          color: Colors.red,
          onPressed: () {},
        ));
  }
}

class CustomContainer extends StatelessWidget {
  final Widget child;

  const CustomContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: TColor.whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 1)],
      ),
      child: child,
    );
  }
}
