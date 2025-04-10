import 'package:flutter/material.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../login_api/discord_login.dart';
import '../login_api/kakao_login.dart';
import '../provider/login_info_provider.dart';

ConsumerWidget KakaoButton(BuildContext context, WidgetRef ref) {
  return LoginButton(onClick: () => loginWithKakao(context, ref), imgSrc: 'assets/icon/kakao.png', text: '카카오 로그인', backgroundColor: const Color(0XFFFEE500), textColor: Colors.black,);
}

ConsumerWidget DiscordButton(BuildContext context, WidgetRef ref) {
  return LoginButton(onClick: () => loginWithDiscord(context, ref), imgSrc: 'assets/icon/discord.png', text: '디스코드 로그인', backgroundColor: const Color(0XFF5865F2), textColor: WHITE,);
}

// 로그인 버튼
class LoginButton extends ConsumerWidget {
  final Future<void> Function() onClick;
  final String imgSrc;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  const LoginButton({required this.onClick, required this.imgSrc, required this.text, required this.backgroundColor, required this.textColor, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
final isLoggingIn = ref.watch(isLoggingInProvider);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 36),
      height: 52,
      child: ElevatedButton(
        onPressed: isLoggingIn ? null : () => onClick(),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imgSrc,
              width: 20,
              height: 21,
            ),
            const SizedBox(width: 16),
            Text(text, style: BODY_16.copyWith(color: textColor)),
          ],
        ),
      ),
    );
  }
}