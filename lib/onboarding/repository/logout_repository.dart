import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:retrofit/retrofit.dart';
import '../../common/api/dio_provider.dart';

part 'logout_repository.g.dart';

@RestApi()
abstract class LogoutApi {
  factory LogoutApi(Dio dio) = _LogoutApi;

  @POST("/api/auth/logout")
  Future<void> logout();
}

class LogoutRepository {
  final LogoutApi api;

  LogoutRepository({
    required this.api,
  });

  Future<void> logout() async {
    try {
      await api.logout();
      await UserApi.instance.unlink();
      await UserApi.instance.logout();
      print('✅ 로그아웃 완료');
    } catch (e) {
      print('❌ 로그아웃 실패: $e');
    }
  }
}

final logoutRepositoryProvider = Provider<LogoutRepository>((ref) {
  final dio = ref.watch(dioAuthProvider);

  return LogoutRepository(
    api: LogoutApi(dio),
  );
});
