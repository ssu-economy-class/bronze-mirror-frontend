import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart' as ImagePicker;
import '../provider/image_picker_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:image_editor/image_editor.dart';
import 'package:permission_handler/permission_handler.dart';

// 카메라 관련 함수

// 이미지 선택 함수 source 값에 따라 카메라, 갤러리로 접근할 수 있음
Future<void> pickImage({
  required BuildContext context,
  required ImagePicker.ImageSource source,
  required Widget nextScreen,
  required StateProvider<XFile?> imageProvider,
}) async {
  final ImagePicker.ImagePicker picker = ImagePicker.ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: source);

  if (pickedFile != null) {
    ProviderScope.containerOf(context).read(imageProvider.notifier).state = pickedFile;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }
}

/// 카메라 권한 요청 함수
Future<bool> requestCameraPermission() async {
  var status = await Permission.camera.request();
  if (status.isGranted) {
    print("✅ 카메라 권한 허용됨");
    return true;
  } else if (status.isDenied) {
    print("❌ 카메라 권한 거부됨");
    return false;
  } else if (status.isPermanentlyDenied) {
    print("🚨 카메라 권한 영구 거부됨 - 설정에서 수동 허용 필요");
    await openAppSettings();
    return false;
  }
  return false;
}

/// 카메라 초기화 함수
Future<CameraController?> initializeCamera() async {
  try {
    final cameras = await availableCameras();
    final controller = CameraController(
      cameras.first,
      ResolutionPreset.medium,
    );
    await controller.initialize();
    return controller;
  } catch (e) {
    print("카메라 초기화 실패: $e");
    return null;
  }
}

/// 사진 캡처 함수
Future<XFile?> captureImage(CameraController? controller) async {
  if (controller == null || !controller.value.isInitialized) return null;
  try {
    final capturedFile = await controller.takePicture();
    print("이미지 캡처 완료: ${capturedFile.path}");
    return capturedFile;
  } catch (e) {
    print("이미지 캡처 실패: $e");
    return null;
  }
}

/// 좌우 반전 적용 함수
/// [isCurrentlyFlipped]의 반대값을 적용한 뒤, 결과 이미지를 반환합니다.
Future<Uint8List?> applyFlip({
  required File imageFile,
  required bool isCurrentlyFlipped,
}) async {
  try {
    final Uint8List imageBytes = await imageFile.readAsBytes();
    final editorOption = ImageEditorOption();
    editorOption.addOption(
      FlipOption(horizontal: !isCurrentlyFlipped, vertical: false),
    );
    final result = await ImageEditor.editImage(
      image: imageBytes,
      imageEditorOption: editorOption,
    );
    return result;
  } catch (e) {
    print("이미지 반전 적용 실패: $e");
    return null;
  }
}

