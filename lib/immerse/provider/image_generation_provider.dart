import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/image_generation_model.dart';
import '../repository/image_repository.dart';

/// 이미지 생성 상태 관리 (비동기)
final imageGenerationProvider = StateNotifierProvider<ImageGenerationNotifier, AsyncValue<ImageGenerationResponse?>>(
      (ref) => ImageGenerationNotifier(ref.watch(imageRepositoryProvider)),
);

class ImageGenerationNotifier extends StateNotifier<AsyncValue<ImageGenerationResponse?>> {
  final ImageRepository repository;

  ImageGenerationNotifier(this.repository) : super(const AsyncValue.data(null));

  /// 이미지 생성 요청
  Future<void> generateImage({
    required String imageUrl,
    required String prompt,
    required int numInferenceSteps,
  }) async {
    state = const AsyncValue.loading();
    try {
      final request = ImageGenerationRequest(
        imageUrl: imageUrl,
        prompt: prompt,
        numInferenceSteps: numInferenceSteps,
      );
      final response = await repository.uploadImage(request);
      state = AsyncValue.data(response);
      print(response);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      print(e);
    }
  }

}
