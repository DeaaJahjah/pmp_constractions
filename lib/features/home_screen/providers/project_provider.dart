import 'package:flutter/cupertino.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/providers/data_provider.dart';

class ProjectProvider extends ChangeNotifier {
  final DataProvider? dataProvider;

  ProjectProvider(this.dataProvider) {
    if (dataProvider != null) {
      projects = dataProvider!.projects;
    }
  }

  List<Project> projects = [];

  search(String value) {
    if (value == '') {
      projects = dataProvider!.projects;
      notifyListeners();
    }
    notifyListeners();
    projects = dataProvider!.projects.where((project) {
      final projectName = project.name.toLowerCase();
      final searchTitle = value.toLowerCase();
      return projectName.contains(searchTitle);
    }).toList();
    notifyListeners();
  }
}
