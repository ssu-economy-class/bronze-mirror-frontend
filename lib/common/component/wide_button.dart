import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const WideButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: PRIMARY_100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(text, style: BODY_BOLD.copyWith(color: WHITE)),
          ),
        ),
    );
  }
}
