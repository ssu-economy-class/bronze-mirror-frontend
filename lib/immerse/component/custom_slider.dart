import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/opacity_provider.dart';

class CustomSlider extends ConsumerWidget {
  const CustomSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double opacity = ref.watch(opacityProvider);

    return Expanded(
      child: Container(
        height: 24.0,
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(50),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SliderTheme(
          data: SliderThemeData(
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
            trackHeight: 2.0,
          ),
          child: Slider(
            value: opacity,
            min: 0.05,
            max: 1.0,
            label: opacity.toStringAsFixed(1),
            onChanged: (value) {
              ref.read(opacityProvider.notifier).setOpacity(value);
            },
            activeColor: PRIMARY,
            inactiveColor: WHITE_GREEN,
          ),
        ),
      ),
    );
  }
}
