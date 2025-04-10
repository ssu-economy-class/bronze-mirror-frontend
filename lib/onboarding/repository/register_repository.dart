import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import '../model/kakao_register_model.dart';
import '../../common/api/dio_provider.dart';

part 'register_repository.g.dart';

final registerRepositoryProvider = Provider<RegisterRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return RegisterRepository(dio);
});

@RestApi()
abstract class RegisterRepository {
  factory RegisterRepository(Dio dio) = _RegisterRepository;

  @POST("/api/auth/af/kakao-login")
  Future<KakaoRegisterResponse> registerWithKakao(@Body() KakaoRegisterRequest request);
}