import 'package:bronze_mirror/common/design_system.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> loginWithKakao(BuildContext context) async {
    try {
      // 카카오톡이 설치되어 있으면 앱을 통해 로그인
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      showSnackBar(context, '카카오톡 로그인 성공!');
      print('카카오톡(앱)으로 로그인 성공: ${token.accessToken}');
    } catch (error) {
      print('카카오톡(앱)으로 로그인 실패: $error');

      // 카카오톡이 설치되지 않은 경우, 웹 브라우저를 통한 로그인 시도
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        showSnackBar(context, '카카오 계정 로그인 성공!');
        print('카카오 계정으로 로그인 성공: ${token.accessToken}');
      } catch (error) {
        showSnackBar(context, '카카오 로그인 실패. 다시 시도해주세요.');
        print('카카오 계정으로 로그인 실패: $error');
      }
    }
  }

  // 사용자에게 로그인 성공/실패 메시지를 보여주는 함수
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
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
        child: Text(
          '카카오로그인',
          style: typoBodyBold,
        ),
      ),
    ),)
    ,
    );
  }
}
