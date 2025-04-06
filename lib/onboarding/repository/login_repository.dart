import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import '../../common/provider/dio_provider.dart';
part 'login_repository.g.dart';

/// 로그인 요청 api 레포지토리
final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return LoginRepository(dio);
});

@RestApi()
abstract class LoginRepository {
  factory LoginRepository(Dio dio) = _LoginRepository;

  @POST("/api/auth/af/login")
  Future<AccessTokenResponse> login(@Body() Map<String, dynamic> body);
}

class AccessTokenResponse {
  final String accessToken;

  AccessTokenResponse({required this.accessToken});

  factory AccessTokenResponse.fromJson(Map<String, dynamic> json) {
    return AccessTokenResponse(accessToken: json['accessToken']);
  }
}
