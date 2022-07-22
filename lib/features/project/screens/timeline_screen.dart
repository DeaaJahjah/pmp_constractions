import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/extensions/firebase.dart';
import 'package:pmpconstractions/features/project/providers/selected_project_provider.dart';
import 'package:pmpconstractions/features/project/screens/back_to_home_screen.dart';
import 'package:pmpconstractions/features/project/screens/widgets/chart_widget.dart';
import 'package:provider/provider.dart';

class TimelineScreen extends StatelessWidget {
  static const String routeName = '/timeline';
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedProjectProvider>(builder: (context, value, child) {
      return ((value.project!.isOpen &&
                  value.project!.memberIn(context.userUid!)) ||
              value.project!.companyId == context.userUid!)
          ? Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                title: const Text('Timeline'),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  ChartWidget(projectId: value.project!.projectId!),
                  // const Timetable(title: 'timetable'),
                ],
              )
              // const Timetable(title: 'timetable'),

              )
          : const BackToHomeScreen();
    });
  }
}
