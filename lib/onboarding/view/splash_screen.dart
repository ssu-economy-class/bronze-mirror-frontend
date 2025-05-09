import 'dart:async';
import 'package:bronze_mirror/common/component/bronze_mirror.dart';
import 'package:bronze_mirror/common/const/common_data.dart';
import 'package:bronze_mirror/common/layout/blur_background.dart';
import 'package:bronze_mirror/common/provider/size_provider.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/common/view/root_tap.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/api/firebase_analytics.dart';
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
    logScreenView(name: 'SplashScreen');
  }

  Future<void> _checkToken() async {
    Future.delayed(const Duration(milliseconds: 1000));

    /// 테스트용 주석
    // final storage = ref.read(secureStorageProvider);
    // storage.write(key: 'accessToken', value: 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIzOTUxODU2MzcxIiwiaWF0IjoxNzQ0MTY0MTY5LCJleHAiOjE3NDQyNTA1Njl9.O4_aWpkXbvEw83N5M5pHnFMQ-D2oli-VamjpEWyj7v7lnbP-cm0nP5EFR50PaQz2tIpKSt9ldl5-lzOn2rWnIQ');
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

    return BlurBackground(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(gradient: BACKGROUND),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Concept(color: WHITE_GREEN,),
              Title(color: LIGHT),
              SizedBox(height: height * 0.075),
              Hero(tag: 'MIRROR', child: const BronzeMirror(size: 200)),
              SizedBox(height: height * 0.075),
            ],
          ),
        ),
      ),
    );
  }
}

class Concept extends ConsumerWidget {
  final Color color;

  const Concept({required this.color, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = ref.read(deviceWidthProvider);
    return SizedBox(
      width: width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '나를 바라보는',
            textAlign: TextAlign.start,
            style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Text('새로운 시선', style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(width: 16),
              Expanded(child: Container(color: color, height: 1,)),
            ],
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  final Color color;

  const Title({required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      APP_NAME,
      style: TextStyle(fontFamily: 'Hambaksnow', fontSize: 48, color: color),
    );
  }
}
