import 'package:flutter/material.dart';

void stuSnackbar(
  BuildContext ctx,
  String content, {
  Color bgColor = Colors.yellow,
}) {
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      backgroundColor: bgColor,
      content: Text(content, style: const TextStyle(color: Colors.white)),
    ),
  );
}
