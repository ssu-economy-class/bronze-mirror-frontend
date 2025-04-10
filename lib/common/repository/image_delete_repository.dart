import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../api/dio_provider.dart';

part 'image_delete_repository.g.dart';

final ImageDeleteRepositoryProvider = Provider<ImageDeleteRepository>((ref) {
  final dio = ref.watch(dioAuthProvider);
  return ImageDeleteRepository(dio);
});

@RestApi()
abstract class ImageDeleteRepository {
  factory ImageDeleteRepository(Dio dio, {String baseUrl}) = _ImageDeleteRepository;

  @DELETE("/api/image/{id}")
  Future<void> deleteImage(@Path("id") String imageId);
}