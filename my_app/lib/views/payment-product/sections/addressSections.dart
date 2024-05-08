import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/common_widgets/address_card.dart';
import 'package:my_app/features/list/ListAddressOrder.dart';
import 'package:my_app/model/addressOrder.model.dart';

class AddressSection extends StatefulWidget {
  final List<AddressOrder> allAddressOrders;
  final ValueChanged<int> handleAddressIndexChanged;

  const AddressSection(
      {Key? key,
      required this.allAddressOrders,
      required this.handleAddressIndexChanged})
      : super(key: key);

  @override
  _AddressSectionState createState() => _AddressSectionState();
}

class _AddressSectionState extends State<AddressSection> {
  int selectedAddressIndex = 0;

  void _handleAddressIndexChanged(int index) {
    setState(() {
      selectedAddressIndex = index;
    });
    widget.handleAddressIndexChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Địa chỉ',
              style: GoogleFonts.nunito(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          AddressCard(
            isSelected: selectedAddressIndex == 0,
            address: widget.allAddressOrders[selectedAddressIndex].addressOrder,
            receiver:
                widget.allAddressOrders[selectedAddressIndex].receiverName,
            phone: widget.allAddressOrders[selectedAddressIndex].phone,
            buttonFunction: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListAddressOrder(
                      allAddressOrders: widget.allAddressOrders,
                      onIndexChanged: _handleAddressIndexChanged,
                    ),
                  ),
                );
              },
              child: Text(
                'Thay đổi',
                style: GoogleFonts.nunito(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
