// 📁 user_info_repository.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import '../../common/provider/dio_provider.dart';
import '../model/user_info_model.dart';

part 'user_info_repository.g.dart';

final userInfoRepositoryProvider = Provider<UserInfoRepository>((ref) {
  final dio = ref.watch(dioAuthProvider);
  return UserInfoRepository(dio);
});

@RestApi()
abstract class UserInfoRepository {
  factory UserInfoRepository(Dio dio) = _UserInfoRepository;

  @GET('/api/user/me')
  Future<UserInfoResponse> getUserInfo();
}