import 'package:bronze_mirror/common/component/bronze_mirror.dart';
import 'package:bronze_mirror/common/const/common_data.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/onboarding/component/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/api/firebase_analytics.dart';
import '../../common/layout/default_layout.dart';
import '../login_api/kakao_login.dart';
import '../provider/login_info_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logScreenView(name: 'FeedScreen');
    double deviceHeight = MediaQuery.of(context).size.height;
    return DefaultLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Title(),
          SizedBox(height: deviceHeight * 0.075),
          Hero(tag: 'MIRROR', child: BronzeMirror()),
          SizedBox(height: deviceHeight * 0.2),
          KakaoButton(context, ref),
          SizedBox(height: 12),
          DiscordButton(context, ref),
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
