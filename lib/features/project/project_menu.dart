import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/extensions/firebase.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:pmpconstractions/core/widgets/custom_snackbar.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/menu_row.dart';
import 'package:pmpconstractions/features/home_screen/services/project_db_service.dart';
import 'package:pmpconstractions/features/project/timeline_screen.dart';
import 'package:pmpconstractions/features/project/update_project_screen.dart';
import 'package:pmpconstractions/features/tasks/providers/selected_project_provider.dart';
import 'package:pmpconstractions/features/tasks/screens/tasks_screen.dart';
import 'package:provider/provider.dart';

class ProjectMenu extends StatefulWidget {
  const ProjectMenu({Key? key}) : super(key: key);

  @override
  State<ProjectMenu> createState() => _ProjectMenuState();
}

class _ProjectMenuState extends State<ProjectMenu> {
  @override
  Widget build(BuildContext context) {
    var project = Provider.of<SelectedProjectProvider>(context).project;
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizedBoxLarge,
          sizedBoxLarge,
          if (project!.hasPermissionToShowTask(context.userUid!) ||
              project.companyId == context.userUid)
            MenuRow(
              icon: Icons.task,
              text: context.loc.tasks,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        TasksScreen(projectId: project.projectId)));
              },
            ),
          sizedBoxMedium,
          MenuRow(
            onTap: () {
              Navigator.of(context).pushNamed(TimelineScreen.routeName);
            },
            icon: Icons.timeline,
            text: context.loc.timeline,
          ),
          sizedBoxMedium,
          if (project.hasPermissionToShowHistory(context.userUid!) ||
              project.companyId == context.userUid)
            MenuRow(
              onTap: () {},
              icon: Icons.history,
              text: context.loc.history,
            ),
          sizedBoxMedium,
          if (project.hasPermissionToStartMeeting(context.userUid!) ||
              project.companyId == context.userUid)
            MenuRow(
              onTap: () {},
              icon: Icons.video_call,
              text: context.loc.start_meeting,
            ),
          sizedBoxMedium,
          if (project.companyId == context.userUid)
            MenuRow(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        UpdateProjectScreen(project: project)));
              },
              icon: Icons.edit,
              text: context.loc.edit,
            ),
          sizedBoxMedium,
          if (project.companyId == context.userUid)
            MenuRow(
              onTap: () async {
                await ProjectDbService()
                    .deleteProject(project.projectId!, project.members!);
                showSuccessSnackBar(context, 'Project deleted successfully');
                Navigator.of(context).pop();
              },
              icon: Icons.delete,
              text: context.loc.delete,
            ),
        ],
      ),
    );
  }
}
