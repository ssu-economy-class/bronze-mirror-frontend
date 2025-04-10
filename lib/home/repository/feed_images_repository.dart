// feed_images_repository.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import '../../common/api/dio_provider.dart';
import '../model/feed_images_model.dart';

part 'feed_images_repository.g.dart';

final feedImagesRepositoryProvider = Provider<FeedImagesRepository>((ref) {
  final dio = ref.watch(dioAuthProvider);
  return FeedImagesRepository(dio);
});

@RestApi()
abstract class FeedImagesRepository {
  factory FeedImagesRepository(Dio dio) = _FeedImagesRepository;

  @GET("/api/image/all-paged")
  Future<FeedImagesResponse> getPagedImages(@Query("page") int page, @Query("size") int size);
}
