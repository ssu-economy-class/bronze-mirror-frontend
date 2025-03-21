import 'package:bronze_mirror/common/view/root_tap.dart';
import 'package:flutter/material.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

// 카카오 로그인 버튼
class KakaoButton extends StatelessWidget {
  const KakaoButton({super.key});

  // 로그인 요청 함수
  Future<void> loginWithKakao(BuildContext context) async {
    try {
      // 카카오톡 앱 로그인 시도
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
    } catch (error) {
      // 카카오톡 앱 로그인 실패
      try {
        // 웹으로 로그인 시도
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      } catch (error) {
        // 웹 로그인 실패
        showSnackBar(context, '카카오톡 로그인 실패. 다시 시도해주세요.');
      }
    }
    // 카카오 로그인 후 RootTap으로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RootTab()),
    );
  }

  // 사용자에게 로그인 성공/실패 메시지를 보여주는 함수(임시)
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 36),
      height: 52,
      child: ElevatedButton(
        onPressed: () => loginWithKakao(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0XFFFEE500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/kakao.png',
              width: 20,
              height: 21,
            ),
            const SizedBox(width: 16),
            Text('카카오 로그인', style: BODY_16.copyWith(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}