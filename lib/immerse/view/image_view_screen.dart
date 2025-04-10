import 'dart:io';
import 'package:bronze_mirror/common/provider/size_provider.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/common/component/wide_button.dart';
import 'package:bronze_mirror/immerse/layout/immerse_layout.dart';
import 'package:bronze_mirror/immerse/provider/image_picker_provider.dart';
import 'package:bronze_mirror/immerse/view/image_draw_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/api/firebase_analytics.dart';

// imagePicker로 불러온 이미지를 보기 위한 스크린
class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    logScreenView(name: 'ImageViewScreen');
    return ImmerseLayout(
      title: 'Select',
      color: WHITE,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: BACKGROUND),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _ImageSection(),
            SizedBox(height: 64),
            WideButton(
              onPressed:
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => ImageDrawScreen()),),
              text: 'Select Image',
            ),
            SizedBox(height: 88),
          ],
        ),
      ),
    );
  }
}

class _ImageSection extends ConsumerWidget {
  const _ImageSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final XFile? image = ref.watch(imageProvider);
    final double deviceHeight = ref.read(deviceHeightProvider);

    // 이미지가 없으면 안내 메시지 출력
    if (image == null) {
      return const Center(child: Text("선택된 이미지가 없거나 형식이 잘못됐습니다."));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double maxHeight = deviceHeight * 0.6; // 최대 높이 제한
          return Image.file(
            File(image.path),
            width: constraints.maxWidth,
            height: maxHeight,
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }
}
