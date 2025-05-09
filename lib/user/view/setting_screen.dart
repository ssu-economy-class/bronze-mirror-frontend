import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/onboarding/provider/secure_storage.dart';
import 'package:bronze_mirror/onboarding/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/api/firebase_analytics.dart';
import '../../onboarding/repository/logout_repository.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    logScreenView(name: 'SettingScreen');
    Color bgColor = WHITE;
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting', style: SUB_TITLE_19),
        backgroundColor: bgColor,
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            _LogoutButton()
          ],
        ),
      ),
    );
  }
}

class _LogoutButton extends ConsumerWidget {
  const _LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () async {
          final repository = ref.read(logoutRepositoryProvider);
          await repository.logout(ref);
          final storage = ref.read(secureStorageProvider);
          storage.deleteAll();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> LoginScreen()));
      },
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.grey.withAlpha(20);
            }
            return null;
          },
        ),
      ),
      child: Text(
        'Logout',
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
