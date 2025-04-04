import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../../common/component/snack_bar.dart';
import '../provider/login_provider.dart'; // 우리가 만든 provider
import '../../common/view/root_tap.dart'; // 로그인 후 이동할 화면

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
    await ref.read(loginProvider(kakaoId.toString()).future);

    // 성공 → 메인 화면 이동
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const RootTab()),
      );
    }
  } catch (error) {
    showSnackBar(context, '사용자 정보를 가져오거나 로그인에 실패했습니다.');
  }
}
