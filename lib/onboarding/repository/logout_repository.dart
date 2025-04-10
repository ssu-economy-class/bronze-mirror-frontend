import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:retrofit/retrofit.dart';
import '../../common/provider/dio_provider.dart';
import '../provider/secure_storage.dart';

part 'logout_repository.g.dart';

@RestApi()
abstract class LogoutApi {
  factory LogoutApi(Dio dio) = _LogoutApi;

  @POST("/api/auth/logout")
  Future<void> logout();
}

class LogoutRepository {
  final LogoutApi api;
  final FlutterSecureStorage storage;

  LogoutRepository({
    required this.api,
    required this.storage,
  });

  Future<void> logout() async {
    try {
      await api.logout();
      await storage.deleteAll();
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
  final storage = ref.watch(secureStorageProvider);

  return LogoutRepository(
    api: LogoutApi(dio),
    storage: storage,
  );
});
