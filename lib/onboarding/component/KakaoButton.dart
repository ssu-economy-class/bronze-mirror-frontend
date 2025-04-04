import 'package:bronze_mirror/common/component/snack_bar.dart';
import 'package:bronze_mirror/common/view/root_tap.dart';
import 'package:flutter/material.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

// 카카오 로그인 버튼
class KakaoButton extends StatelessWidget {
  final VoidCallback onClick;
  const KakaoButton({required this.onClick, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 36),
      height: 52,
      child: ElevatedButton(
        onPressed: onClick,
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