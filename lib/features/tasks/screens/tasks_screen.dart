import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/tasks/screens/widgets/task_card.dart';

class TasksScrenn extends StatelessWidget {
  static const String routeName = '/';
  const TasksScrenn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        centerTitle: true,
        backgroundColor: orange,
        elevation: 0.0,
      ),
      body: ListView(
        children: const [TaskCard()],
      ),
    );
  }
}
