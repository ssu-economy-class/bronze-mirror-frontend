import 'package:bronze_mirror/common/provider/size_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestScreen extends ConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = ref.read(deviceWidthProvider);
    return SafeArea(
      child: Scaffold(
        body: Image.asset(
          'assets/image/background.png',
          width: deviceWidth,
          fit: BoxFit.fill,
          filterQuality: FilterQuality.none,
        ),
      ),
    );
  }
}
