import 'dart:io';
import 'package:bronze_mirror/common/component/bronze_mirror.dart';
import 'package:bronze_mirror/common/const/message.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/common/view/error_screen.dart';
import 'package:bronze_mirror/common/view/root_tap.dart';
import 'package:bronze_mirror/immerse/const/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/api/firebase_analytics.dart';
import '../../common/provider/file_upload_provider.dart';
import '../provider/image_generation_provider.dart';
import '../provider/image_picker_provider.dart';

class MirrorScreen extends ConsumerStatefulWidget {
  const MirrorScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MirrorScreen> createState() => _MirrorScreenState();
}

class _MirrorScreenState extends ConsumerState<MirrorScreen> {
  @override
  void initState() {
    super.initState();
    logScreenView(name: 'MirrorScreen');
    Future.microtask(() async {
      final XFile? finalImage = ref.read(finalImageProvider);

      if (finalImage != null) {
        try {
          final file = File(finalImage.path);
          print(file);
          final imageUrl = await ref.read(fileUploadProvider).upload(file);

          if (!mounted) return;

          print(imageUrl);

          ref.read(imageGenerationProvider.notifier).generateImage(
            imageUrl: imageUrl,
            prompt: PROMPT,
          );
          logEvent(
            name: '이미지 생성',
            parameters: {
              'screen': 'mirror',
            },
          );
        } catch (e) {
          if (!mounted) return;
          logEvent(
            name: '이미지 생성 에러',
            parameters: {
              'screen': 'mirror',
            },
          );
          ref.read(imageGenerationProvider.notifier).setError(e);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageState = ref.watch(imageGenerationProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: BACKGROUND),
        child: imageState.when(
          loading: () => const MirrorLoadingScreen(),
          error: (error, _) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => ErrorScreen(message: SERVER_ERROR),
                  ),
                );
              }
            });
            return const SizedBox.shrink();
          },
          data: (response) {
            if (response == null) return const MirrorLoadingScreen();

            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => RootTab()),
                      (route) => false,
                );
              },
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Hero(
                      tag: response.savedImageUrl,
                      child: ClipOval(
                        child: Image.network(
                          response.savedImageUrl,
                          width: 290,
                          height: 290,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/image/mirror_frame.png',
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  @override
  void dispose() {
    ref.invalidate(imageGenerationProvider);
    super.dispose();
  }

}

class MirrorLoadingScreen extends StatelessWidget {
  const MirrorLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(gradient: BACKGROUND),
      child: const Center(child: BronzeMirrorLoading()),
    );
  }
}
