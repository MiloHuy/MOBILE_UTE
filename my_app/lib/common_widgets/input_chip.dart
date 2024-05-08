import 'package:flutter/material.dart';

class InputChipWidget extends StatelessWidget {
  final Widget label;
  final bool isSelected;
  final Function(bool) onSelected;
  const InputChipWidget({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: label,
      onSelected: (bool value) {
        onSelected(value);
      },
      selected: isSelected,
      deleteIcon: isSelected ? const Icon(Icons.check) : null,
    );
  }
}
