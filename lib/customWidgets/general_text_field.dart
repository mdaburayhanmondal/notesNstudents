import 'package:flutter/material.dart';

class GeneralTextField extends StatelessWidget {
  const GeneralTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.labelColor,
    this.maxLines = 1,
    this.expands = false,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final Color? labelColor;
  final int? maxLines;
  final bool expands;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      expands: expands,
      maxLines: expands ? null : maxLines,
      minLines: expands ? null : 1,
      textAlignVertical: expands
          ? TextAlignVertical.top
          : TextAlignVertical.center,
      decoration: InputDecoration(
        label: Text(label, style: TextStyle(color: labelColor)),
        hintText: hint,
        border: const OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
    );
  }
}
