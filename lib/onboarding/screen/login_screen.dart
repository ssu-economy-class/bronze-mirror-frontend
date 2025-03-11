import 'package:bronze_mirror/common/component/bronze_mirror.dart';
import 'package:bronze_mirror/common/const/common_data.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/onboarding/component/button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Title(),
          SizedBox(height: deviceHeight*0.075),
          BronzeMirror(),
          SizedBox(height: deviceHeight*0.2),
          KakaoButton(),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(APP_NAME, style: TextStyle(
      fontFamily: 'Hambaksnow',
      fontSize: 48,
      color: PRIMARY_400,
    ),);
  }
}