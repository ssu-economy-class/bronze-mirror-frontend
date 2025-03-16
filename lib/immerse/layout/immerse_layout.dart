import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:flutter/material.dart';

// immerse screen의 공통 레이아웃입니다.
class ImmerseLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const ImmerseLayout({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Stack(children: [child, _Appbar(context)])));
  }

  // 앱바
  Widget _Appbar(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          Center(
            child: Text(
              title,
              style: BODY_BOLD.copyWith(color: WHITE),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
