import 'package:bronze_mirror/common/component/bronze_mirror.dart';
import 'package:bronze_mirror/common/layout/blur_background.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/onboarding/component/login_button.dart';
import 'package:bronze_mirror/onboarding/view/splash_screen.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/api/firebase_analytics.dart';
import '../../common/layout/default_layout.dart';
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logScreenView(name: 'FeedScreen');
    double deviceHeight = MediaQuery.of(context).size.height;
    return BlurBackgroundSecond(
      child: DefaultLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Concept(color: PRIMARY_400),
            SizedBox(height: deviceHeight * 0.01),
            Title(color: PRIMARY_400),
            SizedBox(height: deviceHeight * 0.05),
            Hero(tag: 'MIRROR', child: BronzeMirror(size: 180,)),
            SizedBox(height: deviceHeight * 0.1),
            KakaoButton(context, ref),
            SizedBox(height: 12),
            DiscordButton(context, ref),
          ],
        ),
      ),
    );
  }
}