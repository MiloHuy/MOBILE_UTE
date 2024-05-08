import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressCard extends StatefulWidget {
  final VoidCallback? onTap;
  final bool? isSelected;
  final Widget buttonFunction;
  final String address;
  final String receiver;
  final int phone;

  const AddressCard({
    Key? key,
    this.onTap,
    this.isSelected,
    required this.buttonFunction,
    required this.address,
    required this.receiver,
    required this.phone,
  }) : super(key: key);

  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: widget.isSelected != null && widget.isSelected!
                ? Colors.blue
                : Colors.grey,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Icon(Icons.location_on),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.address,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                              fontSize: 16, fontWeight: FontWeight.w300)),
                      const SizedBox(height: 12),
                      Text('Người nhận: ${widget.receiver}',
                          style: GoogleFonts.nunito(
                              fontSize: 16, fontWeight: FontWeight.w300)),
                      const SizedBox(height: 12),
                      Text('Số điện thoại: ${widget.phone}',
                          style: GoogleFonts.nunito(
                              fontSize: 16, fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
                widget.buttonFunction,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
