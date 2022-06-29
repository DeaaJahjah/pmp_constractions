import 'package:flutter/cupertino.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';

class SelectedProjectProvider extends ChangeNotifier {
  Project? project;
  SelectedProjectProvider(this.project);

  updateProject(Project project) {
    this.project = project;
    notifyListeners();
  }
}
