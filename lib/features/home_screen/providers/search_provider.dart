import 'package:flutter/cupertino.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/providers/data_provider.dart';

class SearchProvider extends ChangeNotifier {
  SearchType searchType = SearchType.all;
  List<Project> projectsResult = DataProvider().projects;

  void searchState(SearchType newSearchType) async {
    searchType = newSearchType;
    notifyListeners();
  }
}
