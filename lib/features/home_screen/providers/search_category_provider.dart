import 'package:flutter/cupertino.dart';

import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/features/home_screen/models/search_category.dart';

class SearchCategoryProvider extends ChangeNotifier {
  List<SearchCategory> searchCategories = [
    SearchCategory(
        searchCategory: SearchType.all,
        id: 0,
        name: 'ALL',
        activeIcon: '',
        dactiveIcon: '',
        selected: true),
    SearchCategory(
        searchCategory: SearchType.project,
        id: 1,
        name: 'Bilding',
        activeIcon: 'assets/images/building_dark.png',
        dactiveIcon: 'assets/images/building_orange.png',
        selected: false),
    SearchCategory(
        searchCategory: SearchType.company,
        id: 2,
        name: 'Company',
        activeIcon: 'assets/images/comp_dark.png',
        dactiveIcon: 'assets/images/comp_orange.png',
        selected: false),
    SearchCategory(
        searchCategory: SearchType.engineer,
        id: 3,
        name: 'Engineer',
        activeIcon: 'assets/images/engineer_dark.png',
        dactiveIcon: 'assets/images/engineer_orange.png',
        selected: false),
  ];

  void chnageCategory(int id) {
    for (int i = 0; i < 4; i++) {
      if (searchCategories[i].id == id) {
        searchCategories[i].selected = true;
      } else {
        searchCategories[i].selected = false;
      }
    }
    notifyListeners();
  }
}
