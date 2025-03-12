import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const Button({required this.onPressed, this.text = '', super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}
