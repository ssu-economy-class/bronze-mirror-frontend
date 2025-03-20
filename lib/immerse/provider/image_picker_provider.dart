import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

// ImagePicker로 선택된 단일 이미지의 상태를 관리하는 provider
final imageProvider = StateProvider<XFile?>((ref) => null);

// 최종 프롬프트로 쓰일 이미지의 상태를 관리하는 provider
final finalImageProvider = StateProvider<XFile?>((ref)=>null);