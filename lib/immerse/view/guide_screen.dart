import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/immerse/component/wide_button.dart';
import 'package:bronze_mirror/immerse/layout/immerse_layout.dart';
import 'package:flutter/material.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            WideButton(onPressed: () {}, text: 'Start to Draw'),
            SizedBox(height: 88),
          ],
        ),
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        color: Colors.grey,
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
