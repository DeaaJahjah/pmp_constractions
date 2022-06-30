import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/tasks/models/task.dart';
import 'package:pmpconstractions/features/tasks/providers/selected_project_provider.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/contributer_card.dart';
import 'package:pmpconstractions/features/tasks/services/tasks_db_service.dart';
import 'package:provider/provider.dart';
import 'dart:isolate';
import 'dart:ui';

class TaskDetailsScreen extends StatefulWidget {
  static const String routeName = '/task_details';
  String? taskId;
  TaskDetailsScreen({Key? key, this.taskId}) : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final _controller = ActionSliderController();
  ScrollController scrollController = ScrollController();

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

  final ReceivePort _port = ReceivePort();
  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  void download(String url) async {
    final externalDir = await getExternalStorageDirectory();

    final id = await FlutterDownloader.enqueue(
      url: url,
      savedDir: externalDir!.path,
      showNotification: true,
      openFileFromNotification: true,
    );
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectId =
        Provider.of<SelectedProjectProvider>(context, listen: false)
            .project!
            .projectId;
    return StreamBuilder<Task>(
        stream: TasksDbService()
            .getTaskById(projectId: projectId!, taskId: widget.taskId!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final task = snapshot.data!;
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
                        customText(text: 'Attchment'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Text(
                          //   'water diagram.dxf',
                          //   style: TextStyle(
                          //       fontFamily: font,
                          //       color: white.withOpacity(0.3)),
                          // ),
                          if (task.attchmentUrl != '')
                            ElevatedButton(
                              onPressed: () async {
                                download(task.attchmentUrl);
                                // FileService().requestDownload(
                                //     , task.attchmentUrl);
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
                      SizedBox(
                        height: 300,
                        child: GridView.builder(
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
                      )
                    ]),
                    Positioned(
                      bottom: 15.0,
                      left: 50,
                      child: ActionSlider.standard(
                        sliderBehavior: SliderBehavior.stretch,
                        rolling: true,
                        width: 300.0,
                        height: 54,
                        child: Text('Swipe to submit',
                            style: Theme.of(context).textTheme.bodyMedium),
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
                            child: Center(child: Icon(Icons.check_rounded))),
                        icon: const SizedBox(
                          width: 50,
                          child: Center(child: Icon(Icons.send)),
                        ),
                        onSlide: (controller) async {
                          controller.loading(); //starts loading animation
                          await Future.delayed(const Duration(seconds: 3));
                          controller.success(); //starts success animation
                          await Future.delayed(const Duration(seconds: 1));
                          controller.reset();
                          //resets the slider
                        },
                      ),
                    )
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
