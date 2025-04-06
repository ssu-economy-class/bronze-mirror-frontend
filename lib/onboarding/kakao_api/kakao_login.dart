import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../../common/component/snack_bar.dart';
import '../../common/const/message.dart';
import '../../common/view/root_tap.dart';
import '../provider/secure_storage.dart';
import '../repository/login_repository.dart';
import '../view/register_screen.dart';

Future<void> loginWithKakao(BuildContext context, WidgetRef ref) async {
  try {
    // 카카오톡 앱 로그인 시도
    await UserApi.instance.loginWithKakaoTalk();
  } catch (error) {
    // 카카오톡 앱 로그인 실패 -> 계정 로그인 시도
    try {
      await UserApi.instance.loginWithKakaoAccount();
    } catch (error) {
      showSnackBar(context, '카카오톡 로그인 실패. 다시 시도해주세요.');
      return;
    }
  }

  try {
    // 사용자 정보 요청
    User user = await UserApi.instance.me();

    final kakaoId = user.id;
    final nickname = user.kakaoAccount?.profile?.nickname;
    final profileImageUrl = user.kakaoAccount?.profile?.profileImageUrl;

    debugPrint('✅ Kakao ID: $kakaoId');
    debugPrint('✅ Nickname: $nickname');
    debugPrint('✅ Profile Image: $profileImageUrl');

    // accessToken 요청 + 저장
    final loginRepo = ref.read(loginRepositoryProvider);
    final storage = ref.read(secureStorageProvider);

    try {
      final response = await loginRepo.login({"kakaoId": kakaoId});
      await storage.write(key: "accessToken", value: response.accessToken);

      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const RootTab()),
        );
      }
    } on DioException catch (dioError) {
      if (dioError.response?.statusCode == 403) {
        if (context.mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => RegisterScreen()),
          );
        }
      } else {
        showSnackBar(context, LOGIN_ERROR);
      }
    }
  } catch (error) {
    showSnackBar(context, LOGIN_ERROR);
  }
}
