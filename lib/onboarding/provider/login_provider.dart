import 'package:bronze_mirror/onboarding/provider/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/login_repository.dart';

final loginProvider = FutureProvider.family<void, String>((ref, kakaoId) async {
  final loginRepo = ref.read(loginRepositoryProvider);
  final storage = ref.read(secureStorageProvider);
  final response = await loginRepo.login({"kakaoId": kakaoId});
  await storage.write(key: "accessToken", value: response.accessToken);
});