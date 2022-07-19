import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/firebase.dart';
import 'package:pmpconstractions/features/project/back_to_home_screen.dart';
import 'package:pmpconstractions/features/tasks/models/task.dart';
import 'package:pmpconstractions/features/tasks/providers/selected_project_provider.dart';
import 'package:pmpconstractions/features/tasks/screens/add_task_screen.dart';
import 'package:pmpconstractions/features/tasks/screens/task_details_screen.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/task_card.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/task_state_card.dart';
import 'package:pmpconstractions/features/tasks/services/tasks_db_service.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  static const String routeName = '/tasks';
  final String? projectId;
  const TasksScreen({Key? key, this.projectId}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<String> statesName = ['NOT-STARTED', 'IN-PROGRESS', 'COMPLETED'];
  List<bool> states = [true, false, false];
  TaskState selectedState = TaskState.notStarted;
  int index = 0;
  Key? key = Key(DateTime.now().millisecondsSinceEpoch.toString());
  @override
  Widget build(BuildContext context) {
    //Provider.of<SelectedProjectProvider>(context).checkProjectState(context);
    return Consumer<SelectedProjectProvider>(builder: (context, value, child) {
      return ((value.project!.isOpen &&
                  value.project!.memberIn(context.userUid!)) ||
              value.project!.companyId == context.userUid!)
          ? Scaffold(
              appBar: AppBar(
                title: const Text('Tasks'),
                centerTitle: true,
                backgroundColor: orange,
                elevation: 0.0,
              ),
              body: StreamBuilder<List<Task>>(
                  key: key,
                  stream: TasksDbService().getTasks(
                      projectId: widget.projectId!, taskState: selectedState)
                  //     .asBroadcastStream(onListen: (c) {
                  //   WidgetsBinding.instance.addPostFrameCallback((_) {
                  //     setState(() {});
                  //   });
                  // }),
                  ,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Task> tasks = snapshot.data!;
                      index = 0;
                      return Column(children: [
                        Stack(children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                            color: orange,
                          ),
                          SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: AnimationConfiguration.staggeredList(
                                position: 1,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                    horizontalOffset: 50.0,
                                    child: FadeInAnimation(
                                        child: ListView.builder(
                                      itemCount: 3,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          TaskStateCard(
                                        title: statesName[index],
                                        isSelected: states[index],
                                        onTap: () {
                                          for (int i = 0;
                                              i < states.length;
                                              i++) {
                                            if (i == index) {
                                              states[index] = true;
                                            } else {
                                              states[i] = false;
                                            }
                                          }
                                          switch (index) {
                                            case 0:
                                              selectedState =
                                                  TaskState.notStarted;

                                              break;
                                            case 1:
                                              selectedState =
                                                  TaskState.inProgress;

                                              break;
                                            case 2:
                                              selectedState =
                                                  TaskState.completed;

                                              break;
                                          }
                                          setState(() {});
                                        },
                                      ),
                                    )))),
                          ),
                        ]),
                        Flexible(
                            child: ListView.builder(
                          itemBuilder: (context, index) {
                            return TaskCard(
                              task: tasks[index],
                              index: index,
                              onTap: () {
                                final projectId =
                                    Provider.of<SelectedProjectProvider>(
                                            context,
                                            listen: false)
                                        .project!
                                        .projectId;
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => TaskDetailsScreen(
                                              taskId: tasks[index].id,
                                              projectId: projectId,
                                            )))
                                    .then((value) {
                                  //    ScaffoldMessenger.of(widget.cox).setState(() {});
                                  if (value) {
                                    key = Key(DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString());

                                    setState(() {});
                                  }
                                });
                              },
                            );
                          },
                          itemCount: tasks.length,
                        ))
                      ]);
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return const Center(child: Text('No tasks'));
                  }),
              floatingActionButton:
                  (!Provider.of<SelectedProjectProvider>(context)
                          .project!
                          .hasPermessionToManageTask(context.userUid!))
                      ? FloatingActionButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AddTaskScreen.routeName)
                                .then((value) {});
                          },
                          child: const Icon(Icons.add, color: beg, size: 30),
                          elevation: 10,
                          backgroundColor: orange,
                        )
                      : const SizedBox.shrink())
          : const BackToHomeScreen();
    });
  }
}
