import 'dart:io';
import 'package:bronze_mirror/immerse/provider/image_picker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

// imagePicker로 불러온 이미지를 AR로 보기 위한 스크린

class ArViewScreen extends ConsumerWidget {
  const ArViewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Riverpod provider로부터 선택된 이미지 파일(XFile)을 가져옴
    final XFile? image = ref.watch(imageProvider);

    // 이미지가 없으면 안내 메시지 출력
    if (image == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("이미지 AR 보기")),
        body: const Center(child: Text("선택된 이미지가 없거나 형식이 잘못됐습니다.")),
      );
    }

    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("이미지 AR 보기")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(
              File(image.path),
              width: screenWidth * 0.5,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text("AR 보기 준비 완료", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
