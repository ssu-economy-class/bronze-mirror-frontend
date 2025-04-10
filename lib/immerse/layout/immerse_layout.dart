import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/immerse/view/guide_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// immerse screen의 공통 레이아웃입니다.
class ImmerseLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final Color color;
  final Color backgroundColor;
  final bool isLeftIcon;

  const ImmerseLayout({super.key, required this.child, required this.title, required this.color, this.backgroundColor = Colors.black, this.isLeftIcon = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(backgroundColor: backgroundColor,body: Stack(children: [child, _Appbar(context)])));
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
                icon: Icon(Icons.arrow_back_ios, color: color, size: 24),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          Center(
            child: Text(
              title,
              style: BODY_BOLD.copyWith(color: color),
              textAlign: TextAlign.center,
            ),
          ),
          if(isLeftIcon)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right : 24),
                child: SizedBox(
                  width: 38.0,
                  height: 38.0,
                  child: IconButton(
                    icon: SvgPicture.asset('assets/icon/i.svg', height: 32.0),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => GuideScreen())),
                    style: IconButton.styleFrom(
                      backgroundColor: PRIMARY,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
