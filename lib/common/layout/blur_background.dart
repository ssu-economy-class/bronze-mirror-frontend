import 'dart:ui';
import 'package:flutter/material.dart';

import '../style/design_system.dart';

class BlurBackground extends StatelessWidget {
  final Widget child;
  const BlurBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        const BlurLight(
          width: 150,
          height: 150,
          alignment: Alignment.topRight,
        ),
        const BlurLight(
          width: 150,
          height: 150,
          alignment: Alignment(-1.0, -0.25),
        ),
        const BlurLight(
          width: 150,
          height: 150,
          alignment: Alignment.bottomCenter,
        ),
      ],
    );
  }
}


class BlurLight extends StatelessWidget {
  final double width;
  final double height;
  final Alignment alignment;
  final double blurSigma;
  final Color color;

  const BlurLight({
    super.key,
    required this.width,
    required this.height,
    required this.alignment,
    this.blurSigma = 60,
    this.color = Colors.white10,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withAlpha(36),
                blurRadius: 100,
                spreadRadius: 36,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlurBackgroundSecond extends StatelessWidget {
  final Widget child;
  const BlurBackgroundSecond({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        const BlurPrimary(
          width: 100,
          height: 100,
          alignment: Alignment.topRight,
        ),
        const BlurPrimary(
          width: 100,
          height: 100,
          alignment: Alignment(-1.0, -0.25),
        ),
        const BlurPrimary(
          width: 100,
          height: 100,
          alignment: Alignment.bottomCenter,
        ),
      ],
    );
  }
}

class BlurBackgroundThird extends StatelessWidget {
  final Widget child;
  const BlurBackgroundThird({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        const BlurPrimary(
          width: 100,
          height: 100,
          alignment: Alignment(-1.0, -0.6),
        ),
        const BlurPrimary(
          width: 100,
          height: 100,
          alignment: Alignment(1.0, -0.25),
        ),
        const BlurPrimary(
          width: 100,
          height: 100,
          alignment: Alignment.bottomCenter,
        ),
      ],
    );
  }
}


class BlurPrimary extends StatelessWidget {
  final double width;
  final double height;
  final Alignment alignment;
  final double blurSigma;
  final Color color;

  const BlurPrimary({
    super.key,
    required this.width,
    required this.height,
    required this.alignment,
    this.blurSigma = 120,
    this.color = PRIMARY_100,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withAlpha(20),
                blurRadius: 100,
                spreadRadius: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}