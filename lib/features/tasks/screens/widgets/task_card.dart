import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_stack/image_stack.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pmpconstractions/core/config/constants/constant.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/tasks/models/task.dart';
import 'package:pmpconstractions/features/tasks/screens/task_details_screen.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final int index;
  const TaskCard({Key? key, required this.task, required this.index})
      : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  List<String> images = [];
  int submitedMembers = 0;
  int notSubmitedMembers = 0;
  int days = 0;

  initilizData() async {
    for (var member in widget.task.members!) {
      //get members images
      images.add(member.profilePicUrl!);

      //count submited members
      if (member.submited) {
        submitedMembers++;
      }
      //count not submited members
      if (!member.submited) {
        notSubmitedMembers++;
      }
    }
  }

  int progressValue = 0;
  @override
  void initState() {
    initilizData();
    days = widget.task.endPoint.difference(widget.task.startPoint).inDays;
    progressValue =
        ((submitedMembers / (submitedMembers + notSubmitedMembers)) * 100)
            .toInt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.task.id),
      dragStartBehavior: DragStartBehavior.start,
      startActionPane: ActionPane(motion: const DrawerMotion(), children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: SlidableAction(
              autoClose: true,
              borderRadius: BorderRadius.circular(8),
              onPressed: (Context) {},
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: SlidableAction(
              autoClose: true,
              borderRadius: BorderRadius.circular(8),
              onPressed: (Context) {},
              backgroundColor: const Color.fromARGB(255, 33, 202, 120),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'edit',
            ),
          ),
        ),
      ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text('$days Days',
                style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TaskDetailsScreen(
                          task: widget.task,
                        )));
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(15),
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
                      percent: submitedMembers /
                          (notSubmitedMembers + submitedMembers),
                      center: Text(
                        "$progressValue %",
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
                        '$progressValue% completed',
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
                      imageSource: ImageSource.Asset,
                    ),
                    sizedBoxSmall,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
