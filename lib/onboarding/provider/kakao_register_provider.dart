import 'package:bronze_mirror/onboarding/provider/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/kakao_register_model.dart';
import '../repository/register_repository.dart';

final kakaoRegisterProvider = FutureProvider.family<KakaoRegisterResponse, KakaoRegisterRequest>((ref, request) async {
  final repo = ref.read(registerRepositoryProvider);
  final response = await repo.registerWithKakao(request);
  final storage = ref.read(secureStorageProvider);
  storage.write(key: 'accessToken', value: response.data.accessToken);
  return response;
});
