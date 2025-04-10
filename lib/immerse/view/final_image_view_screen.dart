import 'dart:io';
import 'package:bronze_mirror/common/provider/size_provider.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/common/component/wide_button.dart';
import 'package:bronze_mirror/immerse/provider/image_picker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/api/firebase_analytics.dart';
import 'mirror_screen.dart';
import '../utils/camera.dart';

// finalImage를 보기 위한 스크린
class FinalImageViewScreen extends StatelessWidget {
  const FinalImageViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    logScreenView(name: 'FinalImageScreen');
    return Scaffold(
      body: Container(
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
                  () => Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => MirrorScreen())),
              text: 'Submit',
            ),
            SizedBox(height: 8),
            RollbackText(),
            SizedBox(height: 64),
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
    final XFile? image = ref.watch(finalImageProvider);
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

class RollbackText extends StatelessWidget {
  const RollbackText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => pickImage(
            imageProvider: finalImageProvider,
            source: ImageSource.camera,
            nextScreen: FinalImageViewScreen(),
            context: context,
          ),
      child: Text(
        'Take another photo',
        style: BODY_MID.copyWith(
          color: WHITE,
          decoration: TextDecoration.underline,
          decorationColor: WHITE,
        ),
      ),
    );
  }
}
