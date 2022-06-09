import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/tasks/models/task.dart';
import 'package:pmpconstractions/features/tasks/models/task_member.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/task_card.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/task_state_card.dart';

class TasksScrenn extends StatefulWidget {
  static const String routeName = '/';
  const TasksScrenn({Key? key}) : super(key: key);

  @override
  State<TasksScrenn> createState() => _TasksScrennState();
}

class _TasksScrennState extends State<TasksScrenn> {
  List<String> statesName = ['NOT-STARTED', 'IN-PROGRESS', 'COMPLETED'];
  List<bool> states = [true, false, false];
  @override
  Widget build(BuildContext context) {
    List<Task> tasks = [
      Task(
          id: '1',
          title: 'Water pipes extention',
          description: 'some data some data some data',
          taskState: TaskState.notStarted,
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
          id: '2',
          title: 'Water pipes extention',
          description: 'some data some data some data',
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
      Task(
          id: '3',
          title: 'Water pipes extention',
          description: 'some data some data some data',
          taskState: TaskState.notStarted,
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
        body: ListView(
          children: [
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
            TaskCard(task: tasks[0], index: 0),
            TaskCard(task: tasks[1], index: 1),
            TaskCard(task: tasks[2], index: 2),
            TaskCard(task: tasks[3], index: 3),
          ],
        ));
  }
}
