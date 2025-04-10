import 'package:flutter_riverpod/flutter_riverpod.dart';

final clientInfoProvider = StateProvider<ClientUserInfo?>((ref) => null);

class ClientUserInfo {
  final String clientId;
  final String nickname;
  final String profileImageUrl;

  ClientUserInfo({
    required this.clientId,
    required this.nickname,
    required this.profileImageUrl,
  });
}

final isLoggingInProvider = StateProvider<bool>((ref) => false);