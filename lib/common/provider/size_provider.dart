import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 화면 사이즈
Size? _deviceSize;

/// 화면 사이즈를 제공하는 provider
final deviceSizeProvider = Provider<Size>((ref) {
  if (_deviceSize == null) {
    throw Exception("deviceSizeProvider가 아직 초기화되지 않았습니다.");
  }
  return _deviceSize!;
});

/// 기기의 가로 길이
final deviceWidthProvider = Provider<double>((ref) {
  return ref.watch(deviceSizeProvider).width;
});

/// 기기의 세로 길이
final deviceHeightProvider = Provider<double>((ref) {
  return ref.watch(deviceSizeProvider).height;
});

/// 화면 크기를 초기화 하는 함수
void initializeDeviceSize(BuildContext context) {
  if (_deviceSize == null) {
    _deviceSize = MediaQuery.of(context).size;
  }
}