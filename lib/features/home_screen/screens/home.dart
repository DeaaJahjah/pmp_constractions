import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

import 'package:pmpconstractions/features/home_screen/screens/main_screen.dart';
import 'package:pmpconstractions/features/home_screen/screens/menu..dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final drawerConroller = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkBlue.withOpacity(0.85),
        body: ZoomDrawer(
          controller: drawerConroller,
          shadowLayer2Color: white.withOpacity(0.9),
          shadowLayer1Color: white.withOpacity(0.3),
          swipeOffset: 20,
          style: DrawerStyle.Style1,
          menuScreen: InkWell(
            onTap: () => drawerConroller.close!(),
            child: const MenuScreen(),
          ),
          mainScreen: MainScreen(zoomController: drawerConroller),
          borderRadius: 24.0,
          showShadow: true,
          angle: -8,
          backgroundColor: Colors.white,
          slideWidth: MediaQuery.of(context).size.width * 0.65,
          openCurve: Curves.fastOutSlowIn,
          closeCurve: Curves.bounceIn,
        ));
  }
}
