import 'package:flutter/material.dart';

// LoginScreen, LoadingScreen에서 주로 사용되는 청동거울 이미지입니다.
class BronzeMirror extends StatelessWidget {
  const BronzeMirror({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/logo/bronze_mirror.png', height: 220, width: 220);
  }
}
