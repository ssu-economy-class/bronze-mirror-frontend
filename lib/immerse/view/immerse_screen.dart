import 'package:bronze_mirror/immerse/view/camera_screen.dart';
import 'package:flutter/material.dart';

// ImmerseScreen 진입 시 최초 스크린. UI 디자인 아직 X
class ImmerseScreen extends StatelessWidget {
  const ImmerseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1초 후에 페이지 이동 실행
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CameraScreen()),
      );
    });

    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}