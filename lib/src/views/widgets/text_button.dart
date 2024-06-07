import 'package:flutter/material.dart';
import 'package:get_chat/core/themes/colors.dart';

class TextButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const TextButtonWidget(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: primaryColor, fontSize: 18),
        ));
  }
}
