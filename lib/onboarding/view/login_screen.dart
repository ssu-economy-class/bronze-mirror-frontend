import 'package:bronze_mirror/common/component/bronze_mirror.dart';
import 'package:bronze_mirror/common/const/common_data.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/onboarding/component/KakaoButton.dart';
import 'package:bronze_mirror/onboarding/kakao_api/kakao_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/layout/default_layout.dart';
import '../provider/kakao_info_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double deviceHeight = MediaQuery.of(context).size.height;
    final isLoggingIn = ref.watch(isLoggingInProvider);
    return DefaultLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Title(),
          SizedBox(height: deviceHeight * 0.075),
          Hero(tag: 'MIRROR', child: BronzeMirror()),
          SizedBox(height: deviceHeight * 0.2),
          KakaoButton(
            onClick:
                isLoggingIn ? () => {} : () => loginWithKakao(context, ref),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      APP_NAME,
      style: TextStyle(
        fontFamily: 'Hambaksnow',
        fontSize: 48,
        color: PRIMARY_400,
      ),
    );
  }
}
