import 'dart:io';
import 'package:bronze_mirror/immerse/utils/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../provider/image_generation_provider.dart';
import '../provider/image_picker_provider.dart'; // finalImageProvider를 가져옴

class ImageGenerationScreen extends ConsumerWidget {
  const ImageGenerationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageState = ref.watch(imageGenerationProvider);
    final XFile? finalImage = ref.watch(finalImageProvider); // 선택된 이미지 가져오기

    return Scaffold(
      appBar: AppBar(title: const Text('AI 이미지 생성')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (finalImage != null) ...[
              Image.file(File(finalImage.path), height: 200, fit: BoxFit.cover),
              const SizedBox(height: 10),
              Text('선택된 이미지: ${finalImage.name}'),
            ] else
              const Text('이미지를 선택해주세요'),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: finalImage == null
                  ? null
                  : () async {
                final imageUrl = await uploadImageToFirebase(finalImage); // Firebase 업로드
                ref.read(imageGenerationProvider.notifier).generateImage(
                  imageUrl: imageUrl,
                  prompt: "A fantasy landscape, trending on artstation",
                  numInferenceSteps: 25,
                );
              },
              icon: const Icon(Icons.cloud_upload),
              label: const Text("이미지 생성"),
            ),

            const SizedBox(height: 20),

            imageState.when(
              data: (response) {
                if (response == null) {
                  return const Text('이미지 없음');
                }
                return Column(
                  children: [
                    Image.network(response.generatedImageUrl), // 생성된 이미지 표시
                    const SizedBox(height: 16),
                    Text('저장된 이미지 URL: ${response.savedImageUrl}'),
                  ],
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => Text('오류 발생: $error'),
            ),
          ],
        ),
      ),
    );
  }
}
