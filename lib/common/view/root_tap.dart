import 'package:bronze_mirror/common/const/common_data.dart';
import 'package:bronze_mirror/common/layout/default_layout.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/immerse/view/camera_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin{
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

  void tabListener(){
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: SCREEN_NAMES[index],
      child: Center(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            Center(child:Container(child: Text('Home'))),
            Center(child:Container(child: Text('Map'))),
            CameraScreen(),
            Center(child:Container(child: Text('Calendar'))),
            Center(child:Container(child: Text('User'))),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: PRIMARY_100,
        unselectedItemColor: Colors.black,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        type: BottomNavigationBarType.fixed,
        onTap: (int index){
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
    );
  }
}
