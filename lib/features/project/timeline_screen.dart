import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TimelineScreen extends StatelessWidget {
  static const String routeName = '/timeline';
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Not Started', 25, orange),
      ChartData('In Progress', 38, beg),
      ChartData('Completed', 34, const Color.fromARGB(255, 85, 175, 88)),
    ];
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text('Timeline'),
          centerTitle: true,
        ),
        body: ListView(children: [
          SfCircularChart(
            legend: Legend(
              isResponsive: true,
            ),
            title: ChartTitle(text: 'Tasks', alignment: ChartAlignment.center),
            series: <CircularSeries>[
              // Render pie chart
              PieSeries<ChartData, String>(
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
                  pointColorMapper: (ChartData data, _) => data.color,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y),
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
                const CircleAvatar(radius: 10, backgroundColor: Colors.green),
                const SizedBox(width: 10),
                Text('Complated',
                    style: Theme.of(context).textTheme.headlineSmall)
              ]),
            ],
          ),
        ]));
  }
}

class ChartData {
  final String x;
  final double y;
  final Color color;
  ChartData(this.x, this.y, this.color);
}
