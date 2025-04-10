import 'dart:math' as math;
import 'package:flutter/material.dart';

class BronzeMirrorLoading extends StatefulWidget {
  const BronzeMirrorLoading({Key? key}) : super(key: key);

  @override
  _BronzeMirrorLoadingState createState() => _BronzeMirrorLoadingState();
}

class _BronzeMirrorLoadingState extends State<BronzeMirrorLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (Rect rect) {
            double animatedValue = _controller.value * 2 * math.pi;
            double opacity = math.max(10, 50 + 50 * math.cos(animatedValue));
            return RadialGradient(
              center: Alignment.center,
              radius: 0.5 + 0.5 * math.sin(animatedValue),
              colors: [
                Colors.white.withAlpha(200),
                Colors.white.withAlpha(opacity.toInt()),
                Colors.white.withAlpha(2),
              ],
              stops: [0.0, 0.5, 1.0],
              tileMode: TileMode.clamp,
            ).createShader(rect);
          },
          blendMode: BlendMode.modulate,
          child: child,
        );
      },
      child: const BronzeMirror(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class BronzeMirror extends StatelessWidget {
  const BronzeMirror({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/logo/bronze_mirror.png', height: 220, width: 220);
  }
}
