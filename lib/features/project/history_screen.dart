import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/extensions/firebase.dart';
import 'package:pmpconstractions/features/project/back_to_home_screen.dart';
import 'package:pmpconstractions/features/tasks/providers/selected_project_provider.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedProjectProvider>(builder: (context, value, child) {
      return ((value.project!.isOpen &&
                  value.project!.memberIn(context.userUid!)) ||
              value.project!.companyId == context.userUid!)
          ? Container()
          : const BackToHomeScreen();
    });
  }
}
