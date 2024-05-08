import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/common_widgets/address_card.dart';
import 'package:my_app/common_widgets/button_shadow.dart';
import 'package:my_app/main.dart';
import 'package:my_app/model/addressOrder.model.dart';
import 'package:my_app/views/orders/add_new_address_order.view.dart';

class ListAddressOrder extends StatefulWidget {
  final List<AddressOrder> allAddressOrders;
  final ValueChanged<int> onIndexChanged; // 1. Định nghĩa callback
  const ListAddressOrder(
      {Key? key, required this.allAddressOrders, required this.onIndexChanged})
      : super(key: key);

  @override
  _ListAddressOrderState createState() => _ListAddressOrderState();
}

class _ListAddressOrderState extends State<ListAddressOrder> {
  final userId = prefs?.getString('userId') ?? '';
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Danh sách địa chỉ giao hàng",
              textAlign: TextAlign.start,
              style:
                  GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.allAddressOrders.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: AddressCard(
                      isSelected: index == selectedIndex,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        widget.onIndexChanged(
                            index); // 2. Gọi callback khi index thay đổi
                      },
                      buttonFunction: IconButton(
                        icon: Icon(
                          Icons.check_circle_outline_outlined,
                          color: index == selectedIndex
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        onPressed: () {},
                      ),
                      address: widget.allAddressOrders[index].addressOrder,
                      receiver: widget.allAddressOrders[index].receiverName,
                      phone: widget.allAddressOrders[index].phone,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: ButtonShadowWidget(
                title: 'Thêm địa chỉ',
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNewAddressOrderView(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
