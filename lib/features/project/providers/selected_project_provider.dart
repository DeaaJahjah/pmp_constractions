import 'package:flutter/cupertino.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/features/project/models/project.dart';

class SelectedProjectProvider extends ChangeNotifier {
  Project? project;
  SelectedProjectProvider(this.project);

  updateProject(Project project) {
    this.project = project;
    print('updated');
    notifyListeners();
  }

  bool canSeeDetails(BuildContext context) {
    if (project == null) {
      if (!project!.isOpen && project!.privacy == ProjectPrivacy.private) {
        return false;
      }
    }
    return true;
  }
}
