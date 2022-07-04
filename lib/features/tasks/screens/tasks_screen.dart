import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/tasks/models/task.dart';
import 'package:pmpconstractions/features/tasks/screens/add_task_screen.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/task_card.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/task_state_card.dart';
import 'package:pmpconstractions/features/tasks/services/tasks_db_service.dart';
import 'package:status_change/status_change.dart';

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
int index=0;
  int _processIndex = 0;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        centerTitle: true,
        backgroundColor: orange,
        elevation: 0.0,
      ),
      body: StreamBuilder<List<Task>>(
          stream: TasksDbService()
              .getTasks(projectId: widget.projectId!, taskState: selectedState),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Task> tasks = snapshot.data!;
index=0;
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
                              itemBuilder: (context, index) => TaskStateCard(
                                title: statesName[index],
                                isSelected: states[index],
                                onTap: () {
                                  for (int i = 0; i < states.length; i++) {
                                    if (i == index) {
                                      states[index] = true;
                                    } else {
                                      states[i] = false;
                                    }
                                  }
                                  switch (index) {
                                    case 0:
                                      selectedState = TaskState.notStarted;

                                      break;
                                    case 1:
                                      selectedState = TaskState.inProgress;

                                      break;
                                    case 2:
                                      selectedState = TaskState.completed;

                                      break;
                                  }
                                  setState(() {});
                                },
                              ),
                            )))),
                  ),
                ]),
Flexible(
  child:   StatusChange.tileBuilder(
  
                  theme: StatusChangeThemeData(
  
                    direction: Axis.vertical,
  
                    connectorTheme:
  
                        ConnectorThemeData(space: 1.0, thickness: 1.0),
  
                  ),
  
                  builder: StatusChangeTileBuilder.connected(
  
                    itemWidth: (_) =>
  
                        MediaQuery.of(context).size.width / tasks.length,
  
                    contentWidgetBuilder: (context, index) {
  
                      return Padding(
  
                        padding: const EdgeInsets.all(15.0),
  
                        child: Text(
  
                          'add content here',
  
                          style: TextStyle(
  
                            color: Colors
  
                                .blue, // change color with dynamic color --> can find it with example section
  
                          ),
  
                        ),
  
                      );
  
                    },
  
                    nameWidgetBuilder: (context, index) {
  
                      return Padding(
  
                        padding: const EdgeInsets.all(20),
  
                        child: Text(
  
                          'your text ',
  
                          style: TextStyle(
  
                            fontWeight: FontWeight.bold,
  
                            color: orange,
  
                          ),
  
                        ),
  
                      );
  
                    },
  
                    indicatorWidgetBuilder: (_, index) {
  
                      if (index <= _processIndex) {
  
                        return DotIndicator(
  
                          size: 35.0,
  
                          border: Border.all(color: Colors.green, width: 1),
  
                          child: Padding(
  
                            padding: const EdgeInsets.all(6.0),
  
                            child: Container(
  
                              decoration: BoxDecoration(
  
                                shape: BoxShape.circle,
  
                                color: Colors.green,
  
                              ),
  
                            ),
  
                          ),
  
                        );
  
                      } else {
  
                        return OutlinedDotIndicator(
  
                          size: 30,
  
                          borderWidth: 1.0,
  
                          color: orange,
  
                        );
  
                      }
  
                    },
  
                    lineWidgetBuilder: (index) {
  
                      if (index > 0) {
  
                        if (index == _processIndex) {
  
                          final prevColor = orange;
  
                          final color = beg;
  
                          var gradientColors;
  
                          gradientColors = [
  
                            prevColor,
  
                            Color.lerp(prevColor, color, 0.5)
  
                          ];
  
                          return DecoratedLineConnector(
  
                            decoration: BoxDecoration(
  
                              gradient: LinearGradient(
  
                                colors: gradientColors,
  
                              ),
  
                            ),
  
                          );
  
                        } else {
  
                          return SolidLineConnector(
  
                            color:beg,
  
                          );
  
                        }
  
                      } else {
  
                        return null;
  
                      }
  
                    },
  
                    itemCount: tasks.length,
  
                  ),
  
                ),
),
                // Flexible(
                //     child: ListView.builder(
                //   itemBuilder: (context, index) {
                //     return TaskCard(task: tasks[index], index: index);
                //   },
                //   itemCount: tasks.length,
                // ))
              ]);
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Center(child: Text('No tasks'));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddTaskScreen.routeName);
        },
        child: const Icon(Icons.add, color: beg, size: 30),
        elevation: 10,
        backgroundColor: orange,
      ),
    );
  }
}
