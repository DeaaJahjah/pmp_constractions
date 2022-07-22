import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/project/models/chart.dart';
import 'package:pmpconstractions/features/project/services/timeline_db_servies.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatelessWidget {
  final String projectId;
  const ChartWidget({Key? key, required this.projectId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Chart>>(
        future: TimelineDbServies().getChartData(projectId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final chartData = snapshot.data;
            return Column(
              children: [
                SfCircularChart(
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
                ),
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
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
