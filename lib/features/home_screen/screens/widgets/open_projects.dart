import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/providers/data_provider.dart';
import 'package:pmpconstractions/features/home_screen/providers/engineer_provider.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/cached_image.dart';
import 'package:pmpconstractions/features/project/project_details_screen.dart';
import 'package:pmpconstractions/features/home_screen/services/project_db_service.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OpenProjects extends StatelessWidget {
  final ZoomDrawerController drawerConroller;
  final ScrollController scrollController;
  final PanelController panelController;
  OpenProjects(
      {Key? key,
      required this.scrollController,
      required this.panelController,
      required this.drawerConroller})
      : super(key: key);

  var user = FirebaseAuth.instance.currentUser;
  List<String>? projectIds;

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      switch (user!.displayName) {
        case 'engineer':
          if (Provider.of<EnginnerProvider>(context, listen: true)
              .engineers
              .isNotEmpty) {
            var engineer = Provider.of<EnginnerProvider>(context, listen: true)
                .engineers
                .firstWhere((element) => element.userId == user!.uid);
            projectIds = engineer.projectsIDs;
          }
          break;

        case 'client':
          if (Provider.of<DataProvider>(context, listen: true)
              .clients
              .isNotEmpty) {
            var client = Provider.of<DataProvider>(context, listen: true)
                .clients
                .firstWhere((element) => element.userId == user!.uid);

            projectIds = client.projectsIDs;
          }

          break;
      }
    }
    return FutureBuilder<List<Project>>(
      future: (user?.displayName == 'company')
          ? ProjectDbService().geCompanyOpenProjects(user!.uid)
          : ProjectDbService().getOpenProjects(projectIds ?? []),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Project> projects = snapshot.data!;

          if (projects.isEmpty) {
            return const Center(
              child: Text('no open projects'),
            );
          }
          return ListView.builder(
            controller: scrollController,
            itemCount: projects.length,
            itemBuilder: (context, index) {
              Project project = projects[index];
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: InkWell(
                  onTap: () {
                    panelController.close();
                    drawerConroller.close!();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProjectDetailsScreen(
                            projectId: project.projectId)));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                          child: CashedImage(
                              imageUrl: project.imageUrl,
                              radius: 60,
                              size: 100)),
                      const SizedBox(width: 10),
                      Text(project.name)
                    ],
                  ),
                ),
              );
            },
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
