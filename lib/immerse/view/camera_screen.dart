import 'package:bronze_mirror/common/layout/default_layout.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/immerse/component/button/large_icon_button.dart';
import 'package:bronze_mirror/immerse/provider/image_picker_provider.dart';
import 'package:bronze_mirror/immerse/view/image_view_screen.dart';
import 'package:flutter/material.dart' hide IconButton;
import 'package:image_picker/image_picker.dart';
import '../../common/api/firebase_analytics.dart';
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
    logScreenView(name: 'CameraScreen');
    return DefaultLayout(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: BACKGROUND
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LargeIconButton(
              onPressed: () {
                pickImage(
                  context: context,
                  imageProvider: imageProvider,
                  source: ImageSource.camera,
                  nextScreen: ImageViewScreen(),
                );
              },
              text: '카메라',
              icon: Icons.camera_alt_outlined,
            ),
            SizedBox(width: 16),
            LargeIconButton(
              onPressed: () {
                pickImage(
                  context: context,
                  imageProvider: imageProvider,
                  source: ImageSource.gallery,
                  nextScreen: ImageViewScreen(),
                );
              },
              text: '갤러리',
              icon: Icons.image_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
