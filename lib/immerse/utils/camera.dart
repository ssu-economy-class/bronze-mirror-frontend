import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../provider/image_picker_provider.dart';

// 카메라 관련 함수

// 이미지 선택 함수 source 값에 따라 카메라, 갤러리로 접근할 수 있음
Future<void> pickImage({
  required BuildContext context,
  required ImageSource source,
  required Widget nextScreen,
}) async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: source);
  if (pickedFile != null) {
    // provider에 이미지 파일 값 넘겨주기
    ProviderScope.containerOf(context)
        .read(imageProvider.notifier)
        .state = pickedFile;
    // 그 후 원하는 스크린으로 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }
}
