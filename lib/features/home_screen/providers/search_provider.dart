import 'package:flutter/cupertino.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/features/home_screen/models/company.dart';
import 'package:pmpconstractions/features/home_screen/models/engineer.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/services/project_db_service.dart';

class SearchProvider extends ChangeNotifier {
  List<Project> projects = [];
  List<Company> companies = [];
  List<Engineer> engineers = [];

  dynamic searchState(SearchType searchType) async {
    switch (searchType) {
      case SearchType.all:
        // TODO: Handle this case.
        break;
      case SearchType.project:
        projects = await ProjectDbService().getProjects();
        return projects;
        break;
      case SearchType.company:
        // TODO: Handle this case.
        break;
      case SearchType.engineer:
        // TODO: Handle this case.
        break;
    }
    ChangeNotifier();
  }

  getProjectById(String id) {
    return projects.firstWhere((project) => project.projectId == id);
  }

  List<Project> getProjects(String value) {
    if (value.isEmpty) {
      return projects;
    }

    final searchResult = projects.where((project) {
      return project.name.toLowerCase().contains(value.toLowerCase());
    }).toList();

    ChangeNotifier;
    return searchResult;
  }
}
