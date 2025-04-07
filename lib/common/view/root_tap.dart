import 'package:bronze_mirror/common/const/common_data.dart';
import 'package:bronze_mirror/common/layout/default_layout.dart';
import 'package:bronze_mirror/common/provider/size_provider.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/immerse/view/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RootTab extends ConsumerStatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  int index = 0;
  int screenNum = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // vsync -> 현재 컨트롤러를 선언하는 State 또는 StateWidget을 넣어주면 된다.
    controller = TabController(length: screenNum, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);

    // TODO: implement dispose
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = ref.read(deviceWidthProvider);
    return DefaultLayout(
      title: SCREEN_NAMES[index],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.white,
              selectedItemColor: PRIMARY_100,
              unselectedItemColor: Colors.black,
              selectedFontSize: 10.0,
              unselectedFontSize: 10.0,
              type: BottomNavigationBarType.fixed,
              onTap: (int index) {
                controller.animateTo(index);
              },
              currentIndex: index,
              items: List.generate(
                screenNum,
                (index) => BottomNavigationBarItem(
                  icon: BOTTOMBAR_ICONS[index],
                  label: SCREEN_NAMES[index],
                ),
              ),
            ),
            _ImmerseButton(),
          ],
        ),
      ),
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          Center(child: Container(child: Text('Home'))),
          Center(child: Container(child: Text('Map'))),
          Center(child: Container(child: Text('Immerse'))),
          Center(child: Container(child: Text('Calendar'))),
          Center(child: Container(child: Text('User'))),
        ],
      ),
    );
  }
}

class _ImmerseButton extends ConsumerWidget {
  const _ImmerseButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double width = ref.read(deviceWidthProvider);
    return GestureDetector(
      onTap:
          () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => CameraScreen())),
      child: Container(
        width: width * 0.2,
        height: 60,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline_outlined),
            Text('Immerse', style: TextStyle(fontSize: 10.0)),
          ],
        ),
      ),
    );
  }
}
