import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/featuers/notification/model/notification_model.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_db_service.dart';

import 'package:pmpconstractions/features/home_screen/screens/main_screen.dart';
import 'package:pmpconstractions/features/home_screen/screens/menu..dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/open_projects.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final drawerConroller = ZoomDrawerController();
  final panelController = PanelController();
  @override
  void initState() {
    NotificationProvider().showNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //NotificationProvider().showNotification();
    return Scaffold(
        backgroundColor: darkBlue.withOpacity(0.85),
        body: SlidingUpPanel(
            controller: panelController,
            minHeight: 0,
            maxHeight: 200,
            collapsed:
                Stack(alignment: AlignmentDirectional.topCenter, children: [
              Positioned(
                  top: 0,
                  left: MediaQuery.of(context).size.width / 2,
                  child: const Icon(
                    Icons.drag_handle_rounded,
                    color: Color.fromARGB(141, 255, 204, 128),
                  ))
            ]),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: beg,
            panelBuilder: (scrollController) => OpenProjects(
                  drawerConroller: drawerConroller,
                  scrollController: scrollController,
                  panelController: panelController,
                ),
            body: ZoomDrawer(
              controller: drawerConroller,
              shadowLayer2Color: white.withOpacity(0.9),
              shadowLayer1Color: white.withOpacity(0.3),
              swipeOffset: 20,
              style: DrawerStyle.Style1,
              menuScreen: InkWell(
                onTap: () {
                  NotificationProvider().addNotification(NotificationModle(
                    title: 'New here',
                    body: 'welcome new',
                    category: 'new',
                    imageUrl: '',
                    isReaded: false,
                    pauload: '/notification',
                  ));
                  // drawerConroller.close!();
                  // panelController.close();
                },
                child: MenuScreen(panelController: panelController),
              ),
              mainScreen: MainScreen(zoomController: drawerConroller),
              borderRadius: 24.0,
              showShadow: true,
              angle: -8,
              backgroundColor: Colors.white,
              slideWidth: MediaQuery.of(context).size.width * 0.65,
              openCurve: Curves.fastOutSlowIn,
              closeCurve: Curves.bounceIn,
            )));
  }
}
