import 'package:flutter/cupertino.dart';
import 'package:pmpconstractions/features/home_screen/models/engineer.dart';
import 'package:pmpconstractions/features/home_screen/providers/data_provider.dart';

class EnginnerProvider extends ChangeNotifier {
  final DataProvider? dataProvider;

  EnginnerProvider(this.dataProvider) {
    if (dataProvider != null) {
      engineers = dataProvider!.engineers;
    }
  }

  List<Engineer> engineers = [];

  search(String value) {
    if (value == '') {
      engineers = dataProvider!.engineers;
      notifyListeners();
    }
    notifyListeners();
    engineers = dataProvider!.engineers.where((project) {
      final projectName = project.name.toLowerCase();
      final searchTitle = value.toLowerCase();
      return projectName.contains(searchTitle);
    }).toList();
    notifyListeners();
  }
}
