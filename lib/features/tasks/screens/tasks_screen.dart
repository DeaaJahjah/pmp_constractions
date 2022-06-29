import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/tasks/models/task.dart';
import 'package:pmpconstractions/features/tasks/models/task_member.dart';
import 'package:pmpconstractions/features/tasks/screens/add_task_screen.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/task_card.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/task_state_card.dart';
import 'package:pmpconstractions/features/tasks/services/tasks_db_service.dart';

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
  @override
  Widget build(BuildContext context) {
    // print(Provider.of<SelectedProjectProvider>(context, listen: true)
    //     .project!
    //     .projectId);
    List<Task> tasks = [
      Task(
          id: '1',
          title: 'Water pipes extention',
          description:
              'some data some data some data some data some data some data some data some data some data some data some data some data',
          taskState: TaskState.notStarted,
          startPoint: DateTime(2022, DateTime.june, 5),
          endPoint: DateTime(2022, DateTime.june, 10),
          attchmentUrl: '',
          checkByManager: true,
          members: [
            TaskMember(
                memberId: '1',
                memberName: 'Sawsan ah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: true),
            TaskMember(
                memberId: '2',
                memberName: 'Deaa jah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: true),
            TaskMember(
                memberId: '3',
                memberName: 'Deaa jah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: true),
            TaskMember(
                memberId: '4',
                memberName: 'Deaa jah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: false)
          ]),
      Task(
          id: '2',
          title: 'Water pipes extention',
          description: 'some data some data some data',
          taskState: TaskState.notStarted,
          startPoint: DateTime(2022, DateTime.june, 3),
          endPoint: DateTime(2022, DateTime.june, 9),
          attchmentUrl: '',
          checkByManager: false,
          members: [
            TaskMember(
                memberId: '1',
                memberName: 'Deaa jah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: true),
            TaskMember(
                memberId: '1',
                memberName: 'Deaa jah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: true),
            TaskMember(
                memberId: '1',
                memberName: 'Deaa jah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: true),
            TaskMember(
                memberId: '1',
                memberName: 'Deaa jah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: false),
            TaskMember(
                memberId: '1',
                memberName: 'Deaa jah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: false)
          ]),
      Task(
          id: '3',
          title: 'Water pipes extention',
          description: 'some data some data some data',
          attchmentUrl: '',
          checkByManager: false,
          taskState: TaskState.inProgress,
          startPoint: DateTime(2022, DateTime.june, 5),
          endPoint: DateTime(2022, DateTime.june, 10),
          members: [
            TaskMember(
                memberId: '1',
                memberName: 'Deaa jah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: true),
            TaskMember(
                memberId: '1',
                memberName: 'Deaa jah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: true),
            TaskMember(
                memberId: '1',
                memberName: 'Deaa jah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: true),
            TaskMember(
                memberId: '1',
                memberName: 'Deaa jah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: false)
          ]),
      Task(
          id: '4',
          title: 'Water pipes extention',
          description: 'some data some data some data',
          attchmentUrl: '',
          checkByManager: false,
          taskState: TaskState.notStarted,
          startPoint: DateTime(2022, DateTime.june, 3),
          endPoint: DateTime(2022, DateTime.june, 9),
          members: [
            TaskMember(
                memberId: '1',
                memberName: 'Deaa jah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: true),
            TaskMember(
                memberId: '1',
                memberName: 'Deaa jah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: true),
            TaskMember(
                memberId: '1',
                memberName: 'Deaa jah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: true),
            TaskMember(
                memberId: '1',
                memberName: 'Deaa jah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: false),
            TaskMember(
                memberId: '1',
                memberName: 'Deaa jah',
                role: Role.projectEngineer,
                profilePicUrl: "assets/images/sawsan.png",
                submited: false)
          ]),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        centerTitle: true,
        backgroundColor: orange,
        elevation: 0.0,
      ),
      body: StreamBuilder<List<Task>>(
          stream: TasksDbService().getTasks(
              projectId: widget.projectId ?? '',
              taskState: TaskState.inProgress),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Task> tasks = snapshot.data!;

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
                                  setState(() {});
                                },
                              ),
                            )))),
                  ),
                ]),
                Flexible(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskCard(task: tasks[index], index: index);
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
