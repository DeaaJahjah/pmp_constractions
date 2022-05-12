import 'package:flutter/material.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/services/project_db_service.dart';

class ProjectDetailsScreen extends StatefulWidget {
  static const routeName = '/home/project_details';
  const ProjectDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)!.settings.name;
    print(id);
    return Scaffold(
      body: FutureBuilder<Project>(
        future: ProjectDbService().getProjectById(''),
        builder: (context, snapshot) {
          var project = snapshot.data;

          if (snapshot.hasData) {
            return Center(child: Text(project!.imageUrl));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Text('somthing wrong');
        },
      ),
    );
  }
}
