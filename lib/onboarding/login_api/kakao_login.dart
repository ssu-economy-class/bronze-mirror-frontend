import 'package:bronze_mirror/common/api/firebase_analytics.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../../common/component/snack_bar.dart';
import '../../common/const/message.dart';
import '../../common/view/root_tap.dart';
import '../provider/login_info_provider.dart';
import '../provider/secure_storage.dart';
import '../repository/login_repository.dart';
import '../view/register_screen.dart';

Future<void> loginWithKakao(BuildContext context, WidgetRef ref) async {
  logEvent(
    name: '버튼 클릭',
    parameters: {
      'screen': 'login',
      'button': 'kakao',
    },
  );
  final isLoggingIn = ref.read(isLoggingInProvider);
  if (isLoggingIn) return;

  ref.read(isLoggingInProvider.notifier).state = true;

  try {
    // 카카오톡 앱 로그인 시도
    await UserApi.instance.loginWithKakaoTalk();
  } catch (error) {
    // 앱 로그인 실패 -> 계정 로그인
    try {
      await UserApi.instance.loginWithKakaoAccount();
    } catch (error) {
      showSnackBar(context, '카카오톡 로그인 실패. 다시 시도해주세요.');
      ref.read(isLoggingInProvider.notifier).state = false;
      return;
    }
  }

  try {
    // 사용자 정보 요청
    User user = await UserApi.instance.me();

    final kakaoId = user.id.toString();
    final nickname = user.kakaoAccount?.profile?.nickname;
    final profileImageUrl = user.kakaoAccount?.profile?.profileImageUrl;

    final loginRepo = ref.read(loginRepositoryProvider);
    final storage = ref.read(secureStorageProvider);

    try {
      final response = await loginRepo.login({"kakaoId": kakaoId});
      await storage.write(key: "accessToken", value: response.accessToken);

      print(response.accessToken);

      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const RootTab()),
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        if (context.mounted) {
          ref.read(clientInfoProvider.notifier).state = ClientUserInfo(
            clientId: kakaoId,
            nickname: nickname ?? '',
            profileImageUrl: profileImageUrl ?? '',
          );
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const RegisterScreen()),
          );
        }
      } else {
        showSnackBar(context, LOGIN_ERROR);
      }
    }
  } catch (error) {
    print(error);
    showSnackBar(context, LOGIN_ERROR);
  } finally {
    ref.read(isLoggingInProvider.notifier).state = false;
  }
}
