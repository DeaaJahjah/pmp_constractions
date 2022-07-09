import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_stack/image_stack.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/firebase.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/tasks/models/task.dart';
import 'package:pmpconstractions/features/tasks/providers/selected_project_provider.dart';
import 'package:pmpconstractions/features/tasks/services/tasks_db_service.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final int index;

  final void Function()? onTap;
  const TaskCard(
      {Key? key, required this.task, required this.index, required this.onTap})
      : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  List<String> images = [];

  @override
  void initState() {
    for (var member in widget.task.members!) {
      //get members images
      images.add(member.profilePicUrl!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Project project =
        Provider.of<SelectedProjectProvider>(context, listen: false).project!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text('${widget.task.getTaskDays()} Days',
              style: Theme.of(context).textTheme.bodySmall),
        ),
        InkWell(
            onTap: widget.onTap,
            child: Slidable(
              key: ValueKey(widget.task.id),
              dragStartBehavior: DragStartBehavior.down,
              enabled: project.hasPermessionToManageTask(context.userUid!),
              startActionPane:
                  ActionPane(motion: const DrawerMotion(), children: [
                SlidableAction(
                  padding: const EdgeInsets.all(5),
                  autoClose: true,
                  flex: 2,
                  borderRadius: BorderRadius.circular(8),
                  onPressed: (context) async {
                    String projectId = project.projectId!;
                    await TasksDbService().deleteTask(
                        projectId: projectId, taskId: widget.task.id!);
                  },
                  backgroundColor: orange.withOpacity(0.6),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  autoClose: true,
                  flex: 2,
                  borderRadius: BorderRadius.circular(8),
                  onPressed: (context) {},
                  backgroundColor: beg.withOpacity(0.6),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'edit',
                ),
              ]),
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                    color: (widget.index % 2 == 0) ? beg : orange,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Text(widget.task.title,
                        style: (widget.index % 2 == 0)
                            ? Theme.of(context).textTheme.bodySmall
                            : Theme.of(context).textTheme.headlineSmall),
                    sizedBoxSmall,
                    LinearPercentIndicator(
                      lineHeight: 14.0,
                      percent: (widget.task.members!.isNotEmpty)
                          ? widget.task.getProgressValue()
                          : 0,
                      center: Text(
                        (widget.task.members!.isNotEmpty)
                            ? "${widget.task.getProgressValue() * 100} %"
                            : '0%',
                        style: TextStyle(
                            fontSize: 10.0,
                            color: (widget.index % 2 == 0) ? beg : orange),
                      ),
                      animation: true,
                      animationDuration: 300,
                      curve: Curves.easeInCirc,
                      barRadius: const Radius.circular(8),
                      backgroundColor: (widget.index % 2 == 0)
                          ? orange.withOpacity(0.2)
                          : beg.withOpacity(0.2),
                      progressColor: (widget.index % 2 == 0) ? orange : beg,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        (widget.task.members!.isNotEmpty)
                            ? "${widget.task.getProgressValue() * 100} %"
                            : '0%',
                        style: (widget.index % 2 == 0)
                            ? Theme.of(context).textTheme.bodySmall
                            : Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    sizedBoxSmall,
                    ImageStack(
                      imageList: images,
                      totalCount: images.length,
                      imageRadius: 25,
                      imageBorderColor: (widget.index % 2 == 0) ? orange : beg,
                      imageBorderWidth: 1,
                      imageCount: 3,
                      showTotalCount: true,
                      extraCountTextStyle: TextStyle(
                          color: (widget.index % 2 == 0) ? orange : beg,
                          fontSize: 10),
                      backgroundColor: (widget.index % 2 == 0) ? beg : orange,
                      imageSource: ImageSource.Network,
                    ),
                    sizedBoxSmall,
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
