import 'package:bronze_mirror/common/const/common_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Dio 재사용을 위한 provider
final dioProvider = Provider((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://$ip',
    headers: {
      "Content-Type": "application/json",
    },
    connectTimeout: const Duration(seconds: 1000),  // 서버 연결 최대
    receiveTimeout: const Duration(seconds: 1000), // 응답 수신 최대
    sendTimeout: const Duration(seconds: 1000),  // 데이터 전송 최대
  ));
  return dio;
});