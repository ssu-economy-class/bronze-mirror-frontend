import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:flutter/material.dart';

import '../../user/view/setting_screen.dart';

// 공통적으로 사용될 수 있는 Appbar 레이아웃입니다.
class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? title;
  final Widget? bottomNavigationBar;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppbar(context),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppbar(BuildContext context) {
    if (title == null || title == 'Immerse') {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(title!, style: SUB_TITLE_19),
        ),
        foregroundColor: Colors.black,
        actions: [
          if (title == 'User')
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SettingScreen()),
                );
              },
              icon: Icon(Icons.menu),
            ),
        ],
      );
    }
  }
}
