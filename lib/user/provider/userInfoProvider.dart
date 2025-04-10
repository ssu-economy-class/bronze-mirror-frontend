// ✅ StateNotifier로 전역 상태 관리용 Provider 추가
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user_info_model.dart';
import '../repository/user_info_repository.dart';

final userInfoStateProvider = StateNotifierProvider<UserInfoNotifier, AsyncValue<UserInfoResponse?>>((ref) {
  final repo = ref.watch(userInfoRepositoryProvider);
  return UserInfoNotifier(repository: repo);
});

class UserInfoNotifier extends StateNotifier<AsyncValue<UserInfoResponse?>> {
  final UserInfoRepository repository;

  UserInfoNotifier({required this.repository}) : super(const AsyncValue.loading()) {
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    try {
      final response = await repository.getUserInfo();
      state = AsyncValue.data(response);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void reset() => state = const AsyncValue.loading();
}
