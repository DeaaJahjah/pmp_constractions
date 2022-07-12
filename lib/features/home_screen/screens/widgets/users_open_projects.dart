import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/cached_image.dart';
import 'package:pmpconstractions/features/project/details.dart';
import 'package:pmpconstractions/features/home_screen/services/project_db_service.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class UsersOpenProjects extends StatelessWidget {
  final ZoomDrawerController drawerConroller;
  final ScrollController scrollController;
  final PanelController panelController;
  UsersOpenProjects(
      {Key? key,
      required this.scrollController,
      required this.panelController,
      required this.drawerConroller})
      : super(key: key);

  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
        stream: null,

        // ProjectDbService()
        //     .userProjectsIDS(user!.uid, getcCollectionName(user!.displayName)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var ids = snapshot.data;
            return FutureBuilder<List<Project>>(
              future: ProjectDbService().getOpenProjects(ids),
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
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: InkWell(
                          onTap: () {
                            panelController.close();
                            drawerConroller.close!();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Details(projectId: project.projectId)));
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
          return const SizedBox();
        });
  }
}
