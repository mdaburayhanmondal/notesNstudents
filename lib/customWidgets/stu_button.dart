import 'package:flutter/material.dart';

class StuButton extends StatelessWidget {
  final String btnText;
  final Color? textColor;
  final VoidCallback? onClick;
  const StuButton({
    super.key,
    required this.btnText,
    this.textColor,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onClick ?? () {},
      child: Text(btnText, style: TextStyle(color: textColor ?? Colors.black)),
    );
  }
}
