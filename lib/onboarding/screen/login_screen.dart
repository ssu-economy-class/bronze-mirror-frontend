import 'package:bronze_mirror/onboarding/component/button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: KakaoButton(),
      ),
    );
  }
}
