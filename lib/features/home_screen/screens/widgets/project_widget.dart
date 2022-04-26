import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

class ProjectWidget extends StatelessWidget {
  final String projectId;
  final String name;
  final String imageUrl;
  final int index;
  const ProjectWidget(
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
          print('Project id $projectId');
          Navigator.of(context).pushNamed(
            '/details',
            arguments: RouteSettings(name: '/details', arguments: projectId),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
              height: (index % 2 == 0) ? 300 : 200,
              color: karmedi,
              //   padding: const EdgeInsets.all(5),
              child: Expanded(
                flex: 1,
                child: Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.network(
                          imageUrl,
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
                          padding: const EdgeInsets.all(5),
                          height: 30,
                          width: 192,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            //     borderRadius: BorderRadius.circular(5)
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [Text(name)]),
                        ),
                      ))
                ]),
              )),
        ));
  }
}
