import 'package:bronze_mirror/common/api/dio_provider.dart';
import 'package:bronze_mirror/env.dart';
import 'package:bronze_mirror/firebase_options.dart';
import 'package:bronze_mirror/onboarding/view/splash_screen.dart';
import 'package:bronze_mirror/test/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'common/provider/size_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: NATIVE_APP_KEY,
    javaScriptAppKey: JAVASCRIPT_APP_KEY,
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await initializeDateFormatting('ko_KR', null);
  runApp(ProviderScope(child: _App()));
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Pretendard', primarySwatch: Colors.grey),
      home: Builder(
        builder: (context) {
          initializeDeviceSize(context);
          return SplashScreen();
        },
      ),
    );
  }
}
