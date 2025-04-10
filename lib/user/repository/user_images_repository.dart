import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import '../../common/provider/dio_provider.dart';
import '../model/user_images_model.dart';

part 'user_images_repository.g.dart';

final userImagesRepositoryProvider = Provider<UserImagesRepository>((ref) {
  final dio = ref.watch(dioAuthProvider);
  return UserImagesRepository(dio);
});

@RestApi()
abstract class UserImagesRepository {
  factory UserImagesRepository(Dio dio) = _UserImagesRepository;

  @GET("/api/image/myImage")
  Future<UserImagesResponse> getMyImages();
}
