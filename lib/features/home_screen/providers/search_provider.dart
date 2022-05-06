import 'package:flutter/cupertino.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';

class SearchProvider extends ChangeNotifier {
  SearchType searchType = SearchType.all;

  void searchState(SearchType newSearchType) async {
    searchType = newSearchType;
    NotificationListener;
  }
}

  // getProjectById(String id) {
  //   return projects.firstWhere((project) => project.projectId == id);
  // }

  // getProjects(String value) {
  //   if (value.isEmpty) {
  //     searched = projects;
  //   }

  //   final searchResult = projects.where((project) {
  //     return project.name.toLowerCase().contains(value.toLowerCase());
  //   }).toList();

  //   searched = searchResult;
  //   print('this is searched resualt ${searched.length}');
  //   ChangeNotifier;
  // }