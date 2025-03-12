import 'package:bronze_mirror/common/layout/default_layout.dart';
import 'package:bronze_mirror/immerse/component/button.dart';
import 'package:bronze_mirror/immerse/view/image_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/camera.dart';

// 기기의 카메라, 갤러리와 연동하는 스크린입니다.
class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Button(
              onPressed: () {
                pickImage(
                  context: context,
                  source: ImageSource.camera,
                  nextScreen: ImageViewScreen(),
                );
              },
              text: '카메라',
            ),
            Button(
              onPressed: () {
                pickImage(
                  context: context,
                  source: ImageSource.gallery,
                  nextScreen: ImageViewScreen(),
                );
              },
              text: '갤러리',
            ),
          ],
        ),
      ),
    );
  }
}
