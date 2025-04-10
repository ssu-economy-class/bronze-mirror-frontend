import 'package:bronze_mirror/env.dart';
import 'package:bronze_mirror/onboarding/provider/secure_storage.dart';
import 'package:bronze_mirror/onboarding/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../view/error_screen.dart';

/// 기본 Dio 인스턴스
Dio createBaseDio() {
  return Dio(
    BaseOptions(
      baseUrl: API_URL,
      headers: {"Content-Type": "application/json"},
      connectTimeout: const Duration(seconds: 1000),
      receiveTimeout: const Duration(seconds: 1000),
      sendTimeout: const Duration(seconds: 1000),
    ),
  );
}

/// 일반 API에 쓰이는 Dio Provider
final dioProvider = Provider((ref) => createBaseDio());

/// accessToken 인증 API에 쓰이는 Dio Provider
final dioAuthProvider = Provider<Dio>((ref) {
  final storage = ref.watch(secureStorageProvider);
  final dio = createBaseDio();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await storage.read(key: 'accessToken');
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        handler.next(options);
      },
      onError: (DioException e, handler) async {
        final navigator = navigatorKey.currentState;
        if (e.response?.statusCode == 403) {
          navigator?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => LoginScreen()),
            (route) => false,
          );
        } else {
          print(e.message);
          navigator?.push(
            MaterialPageRoute(
              builder:
                  (_) => ErrorScreen(
                    message: '서버 요청 중 문제가 발생했습니다.\n다시 시도해 주세요.',
                    onRetry: () {
                      navigator.pop();
                    },
                  ),
            ),
          );
        }
        handler.next(e);
      },
    ),
  );

  return dio;
});

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
