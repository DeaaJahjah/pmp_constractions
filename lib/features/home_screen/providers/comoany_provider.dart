import 'package:flutter/cupertino.dart';
import 'package:pmpconstractions/features/home_screen/models/company.dart';
import 'package:pmpconstractions/features/home_screen/providers/data_provider.dart';

class CompanyProvider extends ChangeNotifier {
  final DataProvider? dataProvider;

  CompanyProvider(this.dataProvider) {
    if (dataProvider != null) {
      companies = dataProvider!.companies;
    }
  }

  List<Company> companies = [];

  search(String value) {
    if (value == '') {
      companies = dataProvider!.companies;
      notifyListeners();
    }
    notifyListeners();
    companies = dataProvider!.companies.where((project) {
      final projectName = project.name.toLowerCase();
      final searchTitle = value.toLowerCase();
      return projectName.contains(searchTitle);
    }).toList();
    notifyListeners();
  }
}
