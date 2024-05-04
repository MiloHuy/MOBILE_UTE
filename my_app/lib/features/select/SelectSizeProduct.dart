import 'package:flutter/material.dart';

class SelectSize extends StatefulWidget {
  final List<String> sizes;
  final Function(String?) onSizeChanged;

  const SelectSize(
      {super.key, required this.sizes, required this.onSizeChanged});

  @override
  _SelectSizeState createState() => _SelectSizeState();
}

class _SelectSizeState extends State<SelectSize> {
  String? selectedSize;

  @override
  void initState() {
    super.initState();
    if (widget.sizes.isNotEmpty) {
      selectedSize = widget.sizes[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: const SizedBox(),
        value: selectedSize,
        items: widget.sizes.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value),
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            selectedSize = value;
          });
          widget.onSizeChanged(value);
        },
      ),
    );
  }
}
