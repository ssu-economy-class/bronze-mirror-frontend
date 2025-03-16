import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:flutter/material.dart';

class IconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final IconData icon;

  const IconButton({required this.icon, required this.onPressed, this.text = '', super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 148,
      height: 188,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: PRIMARY_100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: WHITE_GREEN, size: 60),
            SizedBox(height: 24),
            Text(text, style: BODY_14.copyWith(color: WHITE)),
          ],
        ),
      ),
    );
  }
}
