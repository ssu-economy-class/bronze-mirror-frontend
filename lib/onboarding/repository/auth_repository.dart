import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../common/provider/dio_provider.dart';
import '../provider/secure_storage.dart';
part 'auth_repository.g.dart';

/// accessToken이 유효한지 검증하는 api 레포지토리
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final storage = ref.watch(secureStorageProvider);

  return AuthRepositoryWithToken(dio, storage);
});

@RestApi()
abstract class AuthRepository {
  factory AuthRepository(Dio dio) = _AuthRepository;

  @GET("/api/auth/validate")
  Future<void> validateToken();
}

/// accessToken을 읽어 Authorization 헤더에 동적으로 추가하는 wrapper 클래스
class AuthRepositoryWithToken implements AuthRepository {
  final Dio _dio;
  final FlutterSecureStorage _storage;
  final _AuthRepository _repo;

  AuthRepositoryWithToken(this._dio, this._storage)
      : _repo = _AuthRepository(_dio);

  @override
  Future<void> validateToken() async {
    final token = await _storage.read(key: 'accessToken');

    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      _dio.options.headers.remove('Authorization');
    }

    return _repo.validateToken();
  }
}
