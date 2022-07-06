import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/home_screen/services/project_db_service.dart';
import 'package:pmpconstractions/features/project/project_details_screen.dart';
import 'package:pmpconstractions/features/project/project_menu.dart';
import 'package:pmpconstractions/features/tasks/providers/selected_project_provider.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  static const String routeName = '/details';
  String? projectId;
  Details({Key? key, this.projectId}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final drawerConroller = ZoomDrawerController();
  bool loading = true;
  @override
  void initState() {
    ProjectDbService().getProjectById(widget.projectId!).then((value) {
      setState(() {
        Provider.of<SelectedProjectProvider>(context, listen: false)
            .updateProject(value);
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (!loading)
          ? ZoomDrawer(
              controller: drawerConroller,
              shadowLayer2Color: white.withOpacity(0.9),
              shadowLayer1Color: white.withOpacity(0.3),
              swipeOffset: 20,
              style: DrawerStyle.Style1,
              menuScreen: InkWell(
                onTap: () {
                  drawerConroller.close!();
                },
                child: const ProjectMenu(),
              ),
              mainScreen: ProjectDetailsScreen(
                projectId: widget.projectId,
                zoomController: drawerConroller,
              ),
              borderRadius: 24.0,
              showShadow: true,
              angle: -8,
              backgroundColor: Colors.white,
              slideWidth: MediaQuery.of(context).size.width * 0.65,
              openCurve: Curves.fastOutSlowIn,
              closeCurve: Curves.bounceIn,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
