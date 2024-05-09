import 'package:flutter/material.dart';
import 'package:my_app/common/colors.com.dart';

class SettingRow extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onPressed;
  final int number;

  const SettingRow(
      {Key? key,
      required this.icon,
      required this.title,
      required this.number,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 30,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(icon, height: 30, width: 30, fit: BoxFit.contain),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: TColor.blackColor,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.navigate_next, color: TColor.blackColor, size: 15)
          ],
        ),
      ),
    );
  }
}
