import 'package:bronze_mirror/common/provider/size_provider.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/common/component/wide_button.dart';
import 'package:bronze_mirror/immerse/layout/immerse_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 서비스 설명서 스크린
class GuideScreen extends ConsumerWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double height = ref.read(deviceHeightProvider);
    return ImmerseLayout(
      title: 'Select',
      color: Colors.black,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: WHITE,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _ImageSection(),
            _ManualSection(),
            WideButton(onPressed: () => Navigator.of(context).pop(), text: 'Start to Draw'),
            SizedBox(height: height * 0.08),
          ],
        ),
      ),
    );
  }
}

class _ImageSection extends ConsumerWidget {
  const _ImageSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double height = ref.read(deviceHeightProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Image.asset(
        'assets/image/guide.jpg',
        height: height * 0.5,
      ),
    );
  }
}

class _ManualSection extends StatelessWidget {
  const _ManualSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.0),
      child: Text(
        'AR로 띄워진 이미지를\n본인만의 스타일대로 그려보세요!\n\n카메라가 종이를 향하는지 확인하세요!',
        textAlign: TextAlign.center,
        style: BODY_BOLD,
      ),
    );
  }
}
