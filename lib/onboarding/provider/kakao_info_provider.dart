import 'package:flutter_riverpod/flutter_riverpod.dart';

final kakaoInfoProvider = StateProvider<KakaoUserInfo?>((ref) => null);

class KakaoUserInfo {
  final String kakaoId;
  final String nickname;
  final String profileImageUrl;

  KakaoUserInfo({
    required this.kakaoId,
    required this.nickname,
    required this.profileImageUrl,
  });
}

final isLoggingInProvider = StateProvider<bool>((ref) => false);