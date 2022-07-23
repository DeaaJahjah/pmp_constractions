import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/firebase.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/download_state_provider.dart';
import 'package:pmpconstractions/core/featuers/auth/services/file_service.dart';
import 'package:pmpconstractions/core/featuers/notification/model/notification_model.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_db_service.dart';
import 'package:pmpconstractions/core/widgets/custom_snackbar.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/member_card.dart';
import 'package:pmpconstractions/features/project/models/history.dart';
import 'package:pmpconstractions/features/project/models/project.dart';
import 'package:pmpconstractions/features/project/screens/back_to_home_screen.dart';
import 'package:pmpconstractions/features/project/services/history_db_service.dart';
import 'package:pmpconstractions/features/tasks/models/task.dart';
import 'package:pmpconstractions/features/project/providers/selected_project_provider.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/contributer_card.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/search_dropdown.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/swipe_widget.dart';
import 'package:pmpconstractions/features/tasks/services/tasks_db_service.dart';
import 'dart:ui';

import 'package:provider/provider.dart';

class TaskDetailsScreen extends StatefulWidget {
  static const String routeName = '/task_details';
  final String? taskId;
  final String? projectId;
  const TaskDetailsScreen({Key? key, this.taskId, this.projectId})
      : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  ScrollController scrollController = ScrollController();
  String taskId = '';
  getState(TaskState taskState) {
    switch (taskState) {
      case TaskState.notStarted:
        return 'NOT-STARTED';

      case TaskState.inProgress:
        return 'IN-PROGRESS';

      case TaskState.completed:
        return 'COMPLETED';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  var selectedItem;
  List<MemberRole> selectedMembers = [];
  List<MemberRole> members = [];
  bool assigned = false;
  bool firstload = true;
  bool needToReferash = false;
  fecthMembers(List<MemberRole> projectmember, List<MemberRole> taskmember) {
    if (firstload || assigned) {
      for (var member in projectmember) {
        if (!taskmember.contains(member)) {
          members.add(member);
        }
      }
      members.removeWhere((member) => member.role == Role.projectManager);
      assigned = false;
      firstload = false;
      selectedItem = (members.isNotEmpty) ? members[0] : null;
      // setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final project =
        Provider.of<SelectedProjectProvider>(context, listen: false).project!;

    return Consumer<SelectedProjectProvider>(builder: (context, value, child) {
      return ((value.project!.isOpen &&
                  value.project!.memberIn(context.userUid!)) ||
              value.project!.companyId == context.userUid!)
          ? StreamBuilder<Task>(
              stream: TasksDbService().getTaskById(
                  projectId: widget.projectId!, taskId: widget.taskId!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final task = snapshot.data!;

                  fecthMembers(project.members!, task.members!);

                  taskId = task.id!;
                  return Scaffold(
                      appBar: AppBar(
                          title: Text(task.title),
                          elevation: 0.0,
                          centerTitle: true),
                      backgroundColor: darkBlue,
                      body: WillPopScope(
                        onWillPop: () async {
                          Navigator.pop(context, needToReferash);
                          return false;
                        },
                        child: Stack(
                          children: [
                            ListView(controller: scrollController, children: [
                              Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 130, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: beg.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Text(getState(task.taskState))),

                              Container(
                                decoration: BoxDecoration(
                                    color: orange,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'START POINT',
                                            style: TextStyle(
                                                color: darkBlue,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            task.getStartPoint(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          )
                                        ],
                                      ),
                                      Container(
                                        height: 40,
                                        width: 2,
                                        color: darkBlue,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            '  END POINT',
                                            style: TextStyle(
                                                color: darkBlue,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            "  ${task.getStartPoint()}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          )
                                        ],
                                      ),
                                    ]),
                              ),

                              Container(
                                margin: const EdgeInsets.all(40),
                                child: CircularPercentIndicator(
                                  radius: 45,
                                  footer: const Text('Completed'),
                                  percent: (task.members!.isNotEmpty)
                                      ? task.getProgressValue()
                                      : 0,
                                  center: Text(
                                    (task.members!.isNotEmpty)
                                        ? "${task.getProgressValue() * 100} %"
                                        : '0%',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  lineWidth: 8,
                                  backgroundColor: orange.withOpacity(0.2),
                                  animation: true,
                                  animationDuration: 300,
                                  curve: Curves.easeInCirc,
                                  progressColor: orange,
                                ),
                              ),

                              //description
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 4,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: orange,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text('Description',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium),
                                      ],
                                    ),
                                    Text(task.description),
                                  ],
                                ),
                              ),
                              if (task.attchmentUrl != '')
                                customText(text: 'Attachment'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Consumer<DownloadStateProvider>(
                                      builder: (context, value, child) {
                                    // print(value.state);
                                    if (value.state != 0) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircularProgressIndicator(
                                            value: value.state / 100,
                                            color: orange,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                              value.state.toStringAsFixed(0) +
                                                  '%',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                        ],
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  }),
                                  if (task.attchmentUrl != '')
                                    ElevatedButton(
                                      onPressed: () async {
                                        await FileService().download2(
                                            task.attchmentUrl, context);
                                      },
                                      child: Text('DOWNLOAD',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  karmedi)),
                                    )
                                ],
                              ),
                              customText(text: 'Contributers'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GridView.builder(
                                    shrinkWrap: true,
                                    controller: scrollController,
                                    itemCount: task.members!.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 1,
                                            crossAxisSpacing: 2,
                                            childAspectRatio: 1.5),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ContributerCard(
                                          member: task.members![index]);
                                    },
                                  ),
                                  if (project.hasPermessionToManageTask(
                                          context.userUid!) &&
                                      task.taskState != TaskState.completed)
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: Text('Assigned to',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium)),
                                          Expanded(
                                            flex: 2,
                                            child: SearchDropDown(
                                                members: members,
                                                selectedItem: selectedItem,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedItem = value;
                                                    if (selectedItem != null) {
                                                      selectedMembers
                                                          .add(selectedItem!);
                                                      members
                                                          .remove(selectedItem);
                                                      if (members.isEmpty) {
                                                        selectedItem = null;
                                                      }
                                                    }
                                                  });
                                                }),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                              flex: 1,
                                              child: CircleAvatar(
                                                backgroundColor: orange,
                                                child: IconButton(
                                                    onPressed: () async {
                                                      if (selectedMembers
                                                          .isEmpty) {
                                                        showErrorSnackBar(
                                                            context,
                                                            'Please select atleast one member');
                                                        return;
                                                      }
                                                      await TasksDbService()
                                                          .assignedTaskToMember(
                                                              project: project,
                                                              task: task,
                                                              newMember:
                                                                  selectedMembers,
                                                              context: context);

                                                      showSuccessSnackBar(
                                                          context,
                                                          'Task Assigned Successfully');
                                                      setState(() {
                                                        assigned = true;
                                                        selectedMembers = [];
                                                        needToReferash = true;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.add,
                                                      color: beg,
                                                      size: 25,
                                                    )),
                                              )),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              Container(
                                // margin: const EdgeInsets.symmetric(horizontal: 30),
                                constraints: const BoxConstraints(
                                  maxHeight: double.infinity,
                                ),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    controller: scrollController,
                                    itemCount: selectedMembers.length,
                                    itemBuilder: (context, i) => MemberCard(
                                        name: selectedMembers[i].memberName,
                                        role: selectedMembers[i].role!,
                                        photoUrl:
                                            selectedMembers[i].profilePicUrl,
                                        onTap: () {
                                          setState(() {
                                            members.add(selectedMembers[i]);
                                            selectedMembers.removeAt(i);

                                            selectedItem = members.first;
                                          });
                                        })),
                              ),
                              if (!task.submited(context.userUid!))
                                (project.hasPermisionToCompleteTask(
                                        context.userUid!, task))
                                    ? SwipeWidget(
                                        onSlide: (controller) async {
                                          controller
                                              .loading(); //starts loading animation
                                          await Future.delayed(
                                              const Duration(seconds: 1));
                                          controller.success();
                                          await Future.delayed(
                                              const Duration(seconds: 2));
                                          await TasksDbService()
                                              .updateTaskState(
                                            projectId: widget.projectId!,
                                            taskId: widget.taskId!,
                                            taskState: TaskState.completed,
                                          );
                                          controller.reset();
                                        },
                                        text: 'Swipe to complete')
                                    : (task.taskState != TaskState.completed)
                                        ? SwipeWidget(
                                            onSlide: (controller) async {
                                              for (var member
                                                  in task.members!) {
                                                if (member.memberId ==
                                                    context.userUid!) {
                                                  member.submited = true;
                                                  break;
                                                }
                                              }
                                              controller
                                                  .loading(); //starts loading animation
                                              await Future.delayed(
                                                  const Duration(seconds: 1));
                                              controller.success();
                                              await Future.delayed(
                                                  const Duration(seconds: 2));

                                              await TasksDbService().updateTask(
                                                  projectId: widget.projectId!,
                                                  task:
                                                      task); //starts success animation
                                              // await Future.delayed(const Duration(seconds: 2));

                                              if (task.allMembersSubmited() &&
                                                  !task.checkByManager) {
                                                await TasksDbService()
                                                    .updateTaskState(
                                                  projectId: widget.projectId!,
                                                  taskId: widget.taskId!,
                                                  taskState:
                                                      TaskState.completed,
                                                );
                                                return;
                                              }
                                              if (task.allMembersSubmited() &&
                                                  task.checkByManager) {
                                                for (var member
                                                    in project.members!) {
                                                  if (member.role ==
                                                      Role.projectManager) {
                                                    await NotificationDbService().sendNotification(
                                                        member: member,
                                                        notification: NotificationModle(
                                                            title: project.name,
                                                            body:
                                                                '${task.title} , is completed',
                                                            type:
                                                                NotificationType
                                                                    .task,
                                                            projectId: project
                                                                .projectId,
                                                            taskId: taskId,
                                                            imageUrl: project
                                                                .imageUrl,
                                                            isReaded: false,
                                                            pauload:
                                                                '/notification',
                                                            createdAt: DateTime
                                                                .now()));
                                                  }
                                                }
                                              }

                                              //add to history
                                              var name = project.getMemberName(
                                                  context.userUid!);
                                              var imageUrl =
                                                  project.getMemberImage(
                                                      context.userUid!);
                                              HistoryDbServices().addHistory(
                                                  project.projectId!,
                                                  History(
                                                      contant:
                                                          '$name, submited the task ${task.title},',
                                                      date: DateTime.now(),
                                                      imageUrl: imageUrl));

                                              //resets the slider
                                            },
                                            text: 'Swipe to submit')
                                        : const SizedBox.shrink(),
                            ]),
                          ],
                        ),
                      ));
                }
                return const Scaffold(
                  body: Center(
                      child: CircularProgressIndicator(
                    color: orange,
                  )),
                );
              })
          : const BackToHomeScreen();
    });
  }

  customText({required String text}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: orange,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(text, style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
        ],
      ),
    );
  }
}
