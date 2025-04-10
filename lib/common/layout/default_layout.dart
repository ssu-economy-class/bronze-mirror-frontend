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
    } else if(title == 'User'){
      return AppBar(
        toolbarHeight: 100,
        backgroundColor: PRIMARY_500,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(title!, style: SUB_TITLE_19),
        ),
        foregroundColor: WHITE,
        actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const SettingScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                ));
              },
              icon: Icon(Icons.menu),
            ),
        ],
      );
    }
      else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(title!, style: SUB_TITLE_19),
        ),
        foregroundColor: Colors.black,
      );
    }
  }
}
