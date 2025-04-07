import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isActive;
  const WideButton({super.key, this.isActive = true, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: isActive ? onPressed : ()=>{},
          style: ElevatedButton.styleFrom(
            backgroundColor: isActive ? PRIMARY_100 : Color(0XFFC0C0C0),
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
