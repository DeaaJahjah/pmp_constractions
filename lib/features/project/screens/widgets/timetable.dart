import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:time_planner/time_planner.dart';

class Timetable extends StatefulWidget {
  const Timetable({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  List<TimePlannerTask> tasks = [];

  void _addObject(BuildContext context) {
    List<Color?> colors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.cyan
    ];

    setState(() {
      tasks.add(
        TimePlannerTask(
          color: colors[Random().nextInt(colors.length)],
          dateTime: TimePlannerDateTime(
              day: Random().nextInt(10),
              hour: Random().nextInt(14) + 6,
              minutes: Random().nextInt(60)),
          minutesDuration: Random().nextInt(90) + 30,
          daysDuration: 3,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('You click on time planner object')));
          },
          child: Text(
            'this is a demo',
            style: TextStyle(color: Colors.grey[350], fontSize: 12),
          ),
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Random task added to time planner!')));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        TimePlanner(
          startHour: 2,
          endHour: 23,
          headers: [
            TimePlannerTitle(
              date: "7/20/2021",
              title: "tuesday",
              dateStyle: const TextStyle(fontSize: 8, color: white),
              titleStyle: Theme.of(context).textTheme.headlineSmall,
            ),
            TimePlannerTitle(
              date: "7/21/2021",
              title: "wednesday",
              dateStyle: const TextStyle(fontSize: 8, color: white),
              titleStyle: Theme.of(context).textTheme.headlineSmall,
            ),
            TimePlannerTitle(
              date: "7/22/2021",
              title: "thursday",
              dateStyle: const TextStyle(fontSize: 8, color: white),
              titleStyle: Theme.of(context).textTheme.headlineSmall,
            ),
            TimePlannerTitle(
              date: "7/23/2021",
              title: "friday",
              dateStyle: const TextStyle(fontSize: 8, color: white),
              titleStyle: Theme.of(context).textTheme.headlineSmall,
            ),
            TimePlannerTitle(
              date: "7/24/2021",
              title: "saturday",
              dateStyle: const TextStyle(fontSize: 8, color: white),
              titleStyle: Theme.of(context).textTheme.headlineSmall,
            ),
            TimePlannerTitle(
              date: "7/25/2021",
              title: "sunday",
              dateStyle: const TextStyle(fontSize: 8, color: white),
              titleStyle: Theme.of(context).textTheme.headlineSmall,
            ),
            TimePlannerTitle(
              date: "7/26/2021",
              title: "monday",
              dateStyle: const TextStyle(fontSize: 8, color: white),
              titleStyle: Theme.of(context).textTheme.headlineSmall,
            ),
            TimePlannerTitle(
              date: "7/27/2021",
              title: "tuesday",
              dateStyle: const TextStyle(fontSize: 8, color: white),
              titleStyle: Theme.of(context).textTheme.headlineSmall,
            ),
            TimePlannerTitle(
              date: "7/28/2021",
              title: "wednesday",
              dateStyle: const TextStyle(fontSize: 8, color: white),
              titleStyle: Theme.of(context).textTheme.headlineSmall,
            ),
            TimePlannerTitle(
              date: "7/29/2021",
              title: "thursday",
              dateStyle: const TextStyle(fontSize: 8, color: white),
              titleStyle: Theme.of(context).textTheme.headlineSmall,
            ),
            TimePlannerTitle(
              date: "7/30/2021",
              title: "friday",
              dateStyle: const TextStyle(fontSize: 8, color: white),
              titleStyle: Theme.of(context).textTheme.headlineSmall,
            ),
            TimePlannerTitle(
              date: "7/31/2021",
              title: "Saturday",
              dateStyle: const TextStyle(fontSize: 8, color: white),
              titleStyle: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
          tasks: tasks,
          style: TimePlannerStyle(cellWidth: 80, showScrollBar: true),
        ),
        Positioned(
            right: 5,
            bottom: 5,
            child: FloatingActionButton(
              onPressed: () => _addObject(context),
              child: const Icon(Icons.add),
            ))
      ],
    ));
  }
}
