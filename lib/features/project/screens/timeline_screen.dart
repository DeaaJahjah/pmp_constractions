import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/firebase.dart';
import 'package:pmpconstractions/features/project/models/chart.dart';
import 'package:pmpconstractions/features/project/providers/selected_project_provider.dart';
import 'package:pmpconstractions/features/project/screens/back_to_home_screen.dart';
import 'package:pmpconstractions/features/project/services/timeline_db_servies.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TimelineScreen extends StatelessWidget {
  static const String routeName = '/timeline';
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedProjectProvider>(builder: (context, value, child) {
      return ((value.project!.isOpen &&
                  value.project!.memberIn(context.userUid!)) ||
              value.project!.companyId == context.userUid!)
          ? Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                title: const Text('Timeline'),
                centerTitle: true,
              ),
              body: ListView(children: [
                FutureBuilder<List<Chart>>(
                    future: TimelineDbServies()
                        .getChartData(value.project!.projectId!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final chartData = snapshot.data;
                        return SfCircularChart(
                          legend: Legend(
                            isResponsive: true,
                          ),
                          title: ChartTitle(
                              text: 'Tasks', alignment: ChartAlignment.center),
                          series: <CircularSeries>[
                            // Render pie chart
                            PieSeries<Chart, String>(
                                radius: '80%',
                                explode: true,
                                // First segment will be exploded on initial rendering
                                explodeIndex: 0,
                                dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    textStyle: TextStyle(
                                        fontFamily: font,
                                        color: darkBackground,
                                        fontWeight: FontWeight.bold)),
                                enableTooltip: true,
                                dataSource: chartData,
                                dataLabelMapper: (Chart data, _) => data.text,
                                pointColorMapper: (Chart data, _) => data.color,
                                xValueMapper: (Chart data, _) => data.x,
                                yValueMapper: (Chart data, _) => data.y),
                          ],
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(children: [
                      const CircleAvatar(radius: 10, backgroundColor: orange),
                      const SizedBox(width: 10),
                      Text('Not Started',
                          style: Theme.of(context).textTheme.headlineSmall)
                    ]),
                    Row(children: [
                      const CircleAvatar(radius: 10, backgroundColor: beg),
                      const SizedBox(width: 10),
                      Text('In progress',
                          style: Theme.of(context).textTheme.headlineSmall)
                    ]),
                    Row(children: [
                      const CircleAvatar(
                          radius: 10, backgroundColor: Colors.green),
                      const SizedBox(width: 10),
                      Text('Complated',
                          style: Theme.of(context).textTheme.headlineSmall)
                    ]),
                  ],
                ),
              ]))
          : const BackToHomeScreen();
    });
  }
}




//  TimePlanner(
//               // time will be start at this hour on table
//               startHour: 0,
//               // time will be end at this hour on table
//               endHour: 3,
//               // each header is a column and a day
//               headers: const [
//                 TimePlannerTitle(
//                   date: "3/10/2021",
//                   title: "sunday",
//                   dateStyle: TextStyle(fontSize: 8, color: white),
//                 ),
//                 TimePlannerTitle(
//                   date: "3/11/2021",
//                   title: "monday",
//                   dateStyle: TextStyle(fontSize: 8, color: white),
//                 ),
//                 TimePlannerTitle(
//                   date: "3/12/2021",
//                   title: "tuesday",
//                   dateStyle: TextStyle(fontSize: 8, color: white),
//                 ),
//                 TimePlannerTitle(
//                   date: "3/12/2021",
//                   title: "tuesday",
//                   dateStyle: TextStyle(fontSize: 8, color: white),
//                 ),
//                 TimePlannerTitle(
//                   date: "3/12/2021",
//                   title: "tuesday",
//                   dateStyle: TextStyle(fontSize: 8, color: white),
//                 ),
//               ],
//               style: TimePlannerStyle(
//                 backgroundColor: darkBlue,
//                 // default value for height is 80
//                 cellHeight: 60,
//                 // default value for width is 90
//                 cellWidth: 100,

//                 dividerColor: darkBackground,
//                 // showScrollBar: true,
//                 horizontalTaskPadding: 5,

//                 borderRadius: const BorderRadius.all(Radius.circular(8)),
//               ),
//               // List of task will be show on the time planner
//               tasks: tasks,
//             ));

//  List<TimePlannerTask> tasks = [
//       TimePlannerTask(
//         // background color for task
//         color: Colors.purple,

//         // day: Index of header, hour: Task will be begin at this hour
//         // minutes: Task will be begin at this minutes
//         dateTime: TimePlannerDateTime(day: 2, hour: 0, minutes: 0),
//         // Minutes duration of task
//         minutesDuration: 180,
//         // Days duration of task (use for multi days task)
//         daysDuration: Random().nextInt(4) + 1,
//         onTap: () {},
//         child: Text(
//           'this is a task',
//           style: TextStyle(color: Colors.grey[350], fontSize: 12),
//         ),
//       ),
//       TimePlannerTask(
//         // background color for task
//         color: Colors.green,

//         // day: Index of header, hour: Task will be begin at this hour
//         // minutes: Task will be begin at this minutes
//         dateTime: TimePlannerDateTime(day: 1, hour: 2, minutes: 0),
//         // Minutes duration of task
//         minutesDuration: 90,
//         // Days duration of task (use for multi days task)
//         daysDuration: 3,
//         onTap: () {},
//         child: Text(
//           'this is a task',
//           style: TextStyle(color: Colors.grey[350], fontSize: 12),
//         ),
//       ),
//     ];