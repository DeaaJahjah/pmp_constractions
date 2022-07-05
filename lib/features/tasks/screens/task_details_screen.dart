import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/firebase.dart';
import 'package:pmpconstractions/core/featuers/auth/providers/download_state_provider.dart';
import 'package:pmpconstractions/core/featuers/auth/services/file_service.dart';
import 'package:pmpconstractions/core/featuers/notification/model/notification_model.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_db_service.dart';
import 'package:pmpconstractions/features/tasks/models/task.dart';
import 'package:pmpconstractions/features/tasks/providers/selected_project_provider.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/contributer_card.dart';
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
  final _controller = ActionSliderController();
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

  // final ReceivePort _port = ReceivePort();
  @override
  void initState() {
    // IsolateNameServer.registerPortWithName(
    //     _port.sendPort, 'downloader_send_port');
    // _port.listen((dynamic data) {
    //   String id = data[0];
    //   DownloadTaskStatus status = data[1];
    //   int progress = data[2];

    //   setState(() {});
    // });

    // FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }

  // static void downloadCallback(
  //     String id, DownloadTaskStatus status, int progress) {
  //   final SendPort send =
  //       IsolateNameServer.lookupPortByName('downloader_send_port')!;
  //   send.send([id, status, progress]);
  // }

  // void download(String url) async {
  //   final externalDir = await getExternalStorageDirectory();

  //   final id = await FlutterDownloader.enqueue(
  //     url: url,
  //     savedDir: externalDir!.path,
  //     showNotification: true,
  //     openFileFromNotification: true,
  //   );
  // }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final project =
        Provider.of<SelectedProjectProvider>(context, listen: false).project!;
    return StreamBuilder<Task>(
        stream: TasksDbService()
            .getTaskById(projectId: widget.projectId!, taskId: widget.taskId!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final task = snapshot.data!;
            taskId = task.id!;
            return Scaffold(
                appBar: AppBar(
                    title: Text(task.title), elevation: 0.0, centerTitle: true),
                backgroundColor: darkBlue,
                body: Stack(
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          percent: task.getProgressValue(),
                          center: Text(
                            "${task.getProgressValue() * 100} %",
                            style: Theme.of(context).textTheme.bodyMedium,
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
                                    borderRadius: BorderRadius.circular(30),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  Text(value.state.toStringAsFixed(0) + '%',
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
                                await FileService()
                                    .download2(task.attchmentUrl, context);
                              },
                              child: Text('DOWNLOAD',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(karmedi)),
                            )
                        ],
                      ),
                      customText(text: 'Contributers'),
                      Container(
                        child: GridView.builder(
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: task.members!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 1,
                                  crossAxisSpacing: 2,
                                  childAspectRatio: 1.5),
                          itemBuilder: (BuildContext context, int index) {
                            return ContributerCard(
                                member: task.members![index]);
                          },
                        ),
                      ),
                      if (!task.submited(context.userUid!))
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ActionSlider.standard(
                              sliderBehavior: SliderBehavior.stretch,
                              rolling: true,
                              width: 300.0,
                              height: 54,
                              child: Text('Swipe to submit',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              backgroundColor: beg.withOpacity(0.25),
                              toggleColor: orange,
                              iconAlignment: Alignment.centerRight,
                              loadingIcon: const SizedBox(
                                  width: 50,
                                  child: Center(
                                      child: SizedBox(
                                    width: 24.0,
                                    height: 24.0,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      color: beg,
                                    ),
                                  ))),
                              successIcon: const SizedBox(
                                  width: 50,
                                  child:
                                      Center(child: Icon(Icons.check_rounded))),
                              icon: const SizedBox(
                                width: 50,
                                child: Center(child: Icon(Icons.send)),
                              ),
                              onSlide: (controller) async {
                                for (var member in task.members!) {
                                  if (member.memberId == context.userUid!) {
                                    member.submited = true;
                                    break;
                                  }
                                }
                                controller.loading(); //starts loading animation
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                controller.success();
                                await Future.delayed(
                                    const Duration(seconds: 2));
                                await TasksDbService().updateTask(
                                    projectId: widget.projectId!,
                                    task: task); //starts success animation
                                // await Future.delayed(const Duration(seconds: 2));

                                if (task.allMembersSubmited() &&
                                    !task.checkByManager) {
                                  await TasksDbService().updateTaskState(
                                      projectId: widget.projectId!,
                                      taskId: widget.taskId!,
                                      taskState: TaskState.completed);
                                  return;
                                }
                                if (task.allMembersSubmited() &&
                                    task.checkByManager) {
                                  for (var member in project.members!) {
                                    if (member.role == Role.projectManager) {
                                      await NotificationDbService()
                                          .sendNotification(
                                              member: member,
                                              notification: NotificationModle(
                                                title: project.name,
                                                body:
                                                    '${task.title} , is completed',
                                                type: NotificationType.task,
                                                projectId: project.projectId,
                                                taskId: taskId,
                                                imageUrl: project.imageUrl,
                                                isReaded: false,
                                                pauload: '/notification',
                                              ));
                                    }
                                  }
                                }

                                //resets the slider
                              },
                            ),
                          ),
                        ),
                    ]),
                  ],
                ));
          }
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: orange,
            )),
          );
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
