import 'package:bronze_mirror/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:dio/dio.dart';
import '../../common/component/snack_bar.dart';
import '../../common/const/message.dart';
import '../../common/view/root_tap.dart';
import '../provider/login_info_provider.dart';
import '../provider/secure_storage.dart';
import '../repository/login_repository.dart';
import '../view/register_screen.dart';

String getDiscordAvatarUrl(String userId, String? avatarHash) {
  if (avatarHash == null || avatarHash.isEmpty) {
    return 'https://cdn.discordapp.com/embed/avatars/0.png';
  }
  return 'https://cdn.discordapp.com/avatars/$userId/$avatarHash.png';
}

Future<void> loginWithDiscord(BuildContext context, WidgetRef ref) async {
  final isLoggingIn = ref.read(isLoggingInProvider);
  if (isLoggingIn) return;

  ref.read(isLoggingInProvider.notifier).state = true;

  const callbackUrlScheme = 'bronzemirror';

  final authUrl = Uri.https('discord.com', '/api/oauth2/authorize', {
    'response_type': 'code',
    'client_id': DISCORD_CLIENT_ID,
    'scope': 'identify email',
    'redirect_uri': '$DISCORD_API_URL/login/oauth2/code/discord',
  });

  debugPrint("🔵 시작: Discord OAuth 인증 URL: $authUrl");

  try {
    final result = await FlutterWebAuth2.authenticate(
      url: authUrl.toString(),
      callbackUrlScheme: callbackUrlScheme,
    ).catchError((e) {
      debugPrint("🔴 WebAuth2 오류 발생 (catchError): $e");
      throw e;
    });

    debugPrint("🟢 리디렉트 결과 URL: $result");

    final uri = Uri.parse(result);
    final discordId = uri.queryParameters['id'];
    final username = uri.queryParameters['username'];
    final avatar = uri.queryParameters['avatar'];
    final accessToken = uri.queryParameters['accessToken'];

    final avatarUrl = getDiscordAvatarUrl(discordId!, avatar);

    debugPrint("🟡 파싱된 유저 정보 → id: $discordId, username: $username, avatarUrl: $avatarUrl, accessToken: $accessToken");

    if (discordId == null || username == null || accessToken == null) {
      throw Exception('❗ 필수 사용자 정보 누락');
    }

    final loginRepo = ref.read(loginRepositoryProvider);
    final storage = ref.read(secureStorageProvider);

    try {
      debugPrint("📤 서버에 로그인 요청 중...");
      final response = await loginRepo.login({"kakaoId": discordId});
      await storage.write(key: "accessToken", value: response.accessToken);
      debugPrint("✅ 로그인 성공, 토큰 저장 완료");

      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const RootTab()),
        );
      }
    } on DioException catch (e) {
      debugPrint("⚠️ DioException: ${e.response?.statusCode} / ${e.response?.data}");

      if (e.response?.statusCode == 401) {
        if (context.mounted) {
          ref.read(clientInfoProvider.notifier).state = ClientUserInfo(
            clientId: discordId,
            nickname: username,
            profileImageUrl: avatarUrl,
          );
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const RegisterScreen()),
          );
        }
      } else {
        showSnackBar(context, LOGIN_ERROR);
      }
    }
  } catch (error, stack) {
    debugPrint('❌ Discord 로그인 실패: $error');
    debugPrint('🧵 StackTrace: $stack');
    showSnackBar(context, 'Discord 로그인 실패. 다시 시도해주세요.');
  } finally {
    ref.read(isLoggingInProvider.notifier).state = false;
  }
}
