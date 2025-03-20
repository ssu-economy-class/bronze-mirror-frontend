import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 투명도 상태를 관리하는 Notifier
class OpacityNotifier extends StateNotifier<double> {
  OpacityNotifier() : super(0.5); // 기본값 0.5

  /// 투명도 변경
  void setOpacity(double value) {
    state = value;
  }
}

/// 투명도 상태를 제공하는 Provider
final opacityProvider = StateNotifierProvider<OpacityNotifier, double>(
      (ref) => OpacityNotifier(),
);