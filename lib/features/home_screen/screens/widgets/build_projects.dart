import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/project_widget.dart';

class BuildProjects extends StatelessWidget {
  final List<Project> projects;
  const BuildProjects({Key? key, required this.projects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        // vertical gap between two items
        mainAxisSpacing: 40,
        // horizontal gap between two items
        crossAxisSpacing: 10,
        itemCount: projects.length,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (context, i) {
          Project project = projects[i];
          return ProjectWidget(
            name: project.name,
            projectId: project.projectId.toString(),
            imageUrl: project.imageUrl,
            index: i,
          );
        });
  }
}
