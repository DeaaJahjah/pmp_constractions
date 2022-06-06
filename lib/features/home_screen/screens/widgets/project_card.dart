import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/home_screen/screens/project_details_screen.dart';

class ProjectCard extends StatelessWidget {
  final String projectId;
  final String name;
  final String? imageUrl;
  final int index;
  const ProjectCard(
      {Key? key,
      required this.projectId,
      required this.name,
      required this.imageUrl,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ProjectDetailsScreen(projectId: projectId)));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
              height: (index % 2 == 0) ? 300 : 200,
              color: karmedi,
              child: Expanded(
                flex: 1,
                child: Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          height: 35,
                          width: 192,
                          decoration: const BoxDecoration(
                            color: orange,
                            //     borderRadius: BorderRadius.circular(5)
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  name,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                )
                              ]),
                        ),
                      ))
                ]),
              )),
        ));
  }
}
