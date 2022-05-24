import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/project_card.dart';

class BuildProjects extends StatelessWidget {
  final List<Project> projects;
  final ScrollController? scrollController;
  const BuildProjects({Key? key, required this.projects, this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
        controller: scrollController,
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
          return AnimationConfiguration.staggeredList(
              position: i,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: ProjectCard(
                      name: project.name,
                      projectId: project.projectId.toString(),
                      imageUrl: project.imageUrl,
                      index: i,
                    ),
                  )));
        });
  }
}
