import 'dart:async';
import 'package:bronze_mirror/common/component/bronze_mirror.dart';
import 'package:bronze_mirror/common/const/common_data.dart';
import 'package:bronze_mirror/common/provider/size_provider.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/common/view/root_tap.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/component/snack_bar.dart';
import '../repository/auth_repository.dart';
import 'login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Timer? _retryTimer;

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final authRepo = ref.read(authRepositoryProvider);

    try {
      await authRepo.validateToken();
      if (!mounted) return;
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const RootTab()));
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else {
        // 네트워크 등 기타 오류 발생
        if (mounted) {
          showSnackBar(context, '서버 요청 중 문제가 발생했습니다.');
          _retryTimer = Timer(const Duration(seconds: 5), _checkToken);
        }
      }
    }
  }

  @override
  void dispose() {
    _retryTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = ref.read(deviceHeightProvider);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: BACKGROUND),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _Title(),
            SizedBox(height: height * 0.075),
            Hero(tag: 'MIRROR', child: const BronzeMirror()),
            SizedBox(height: height * 0.075),
          ],
        ),
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
      style: TextStyle(fontFamily: 'Hambaksnow', fontSize: 48, color: LIGHT),
    );
  }
}
