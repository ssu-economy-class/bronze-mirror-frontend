import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import '../../common/provider/dio_provider.dart';
import '../model/image_generation_model.dart';
part 'image_repository.g.dart';

/// Image Repository Provider
final imageRepositoryProvider = Provider<ImageRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ImageRepository(dio);
});

@RestApi()
abstract class ImageRepository {
  factory ImageRepository(Dio dio) = _ImageRepository;

  @POST("/api/predict")
  Future<ImageGenerationResponse> uploadImage(
      @Body() ImageGenerationRequest request,
      );
}
