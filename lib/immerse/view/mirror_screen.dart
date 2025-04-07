import 'package:bronze_mirror/common/component/bronze_mirror.dart';
import 'package:bronze_mirror/common/const/message.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/common/view/error_screen.dart';
import 'package:bronze_mirror/common/view/root_tap.dart';
import 'package:bronze_mirror/immerse/utils/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../provider/image_generation_provider.dart';
import '../provider/image_picker_provider.dart';

// ai로 생성된 이미지를 보기 위한 예시 스크린
class MirrorScreen extends ConsumerStatefulWidget {
  const MirrorScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MirrorScreen> createState() => _MirrorScreenState();
}

class _MirrorScreenState extends ConsumerState<MirrorScreen> {
  bool _hasRequested = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final XFile? finalImage = ref.read(finalImageProvider);

    // 최초 1회만 요청
    if (!_hasRequested && finalImage != null) {
      _hasRequested = true;

      uploadImageToFirebase(finalImage)
          .then((imageUrl) {
            ref
                .read(imageGenerationProvider.notifier)
                .generateImage(
                  imageUrl: imageUrl,
                  prompt:
                      "Edit the portrait photo to change only the background color. Keep the person’s features, expression, and details intact. The new background should feature a gradient of warm colors, such as orange, pink, and purple, resembling a sunset. Ensure that the person remains the focal point of the image while the background complements the overall mood",
                );
          })
          .catchError((error) {
            ref.read(imageGenerationProvider.notifier).setError(error);
          });
    }
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
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => ErrorScreen(message: SERVER_ERROR),
                ),
              );
            });
            return null;
          },
          data: (response) {
            if (response == null) {
              return null;
            }
            return GestureDetector(
              onTap:
                  () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => RootTab()),
                    (route) => false,
                  ),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipOval(
                      child: Image.network(
                        response.savedImageUrl,
                        width: 290,
                        height: 290,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // 2. 도넛 프레임
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
}

class MirrorLoadingScreen extends StatelessWidget {
  const MirrorLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(gradient: BACKGROUND),
        child: Center(child: BronzeMirror()),
      ),
    );
  }
}
