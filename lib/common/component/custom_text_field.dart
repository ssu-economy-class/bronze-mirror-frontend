import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.validator,
  });

  bool get _isEmpty => controller.text.isEmpty;

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = controller.text.isEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: BODY_18.copyWith(color: const Color(0xFF9EA4A9))),
          StatefulBuilder(
            builder: (context, setState) {
              controller.addListener(() {
                setState(() {});
              });

              return TextFormField(
                controller: controller,
                validator: validator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: isEmpty
                      ? const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))
                      : const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF408F55))),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF408F55)),
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
