import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../../core/model/tab_model.dart';
import '../indo/indo_screen.dart';
import '../worldwide/world_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage;
  String currentTitle;
  Color currentColor;

  final PageStorageBucket bucket = PageStorageBucket();
  final List<Widget> listPage = [
    IndoPage(),
    ListsData(
      key: PageStorageKey('Page 2'),
    )
  ];

  @override
  void initState() {
    currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          bottomNavigationBar: CubertoBottomBar(
            inactiveIconColor: Color(0xFF267466),
            tabStyle: CubertoTabStyle.STYLE_FADED_BACKGROUND,
            selectedTab:
                currentPage, // By default its NO_DRAWER (Availble START_DRAWER and END_DRAWER as per where you want to how the drawer icon in Cuberto Bottom bar)
            tabs: tabs
                .map((value) => TabData(
                    iconData: value.icon,
                    title: value.title,
                    tabColor: value.color,
                    tabGradient: value.gradient))
                .toList(),
            onTabChangedListener: (position, title, color) {
              setState(() {
                currentPage = position;
                currentTitle = title;
                currentColor = color;
              });
            },
          ),
          body: PageStorage(
              bucket: bucket, child: SafeArea(child: listPage[currentPage]))),
    );
  }
}
