import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import '../../common/provider/dio_provider.dart';
import '../provider/secure_storage.dart';
part 'logout_repository.g.dart';

/// 로그아웃 요청 api 레포지토리
final logoutRepositoryProvider = Provider<LogoutRepository>((ref) {
  final dio = ref.watch(dioAuthProvider);
  // accessToken을 포함한 storage 데이터 비워주기
  final storage = ref.watch(secureStorageProvider);
  storage.deleteAll();
  return LogoutRepository(dio);
});

@RestApi()
abstract class LogoutRepository {
  factory LogoutRepository(Dio dio) = _LogoutRepository;

  @POST("/api/auth/logout")
  Future<void> logout();
}
