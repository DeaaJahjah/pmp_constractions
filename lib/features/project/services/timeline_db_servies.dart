import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/project/models/chart.dart';

class TimelineDbServies {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Chart>> getChartData(String projectId) async {
    final QuerySnapshot snapshot = await _db
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .get();

    List<Chart> chartData = [
      Chart(x: 'Not Started', y: 0, color: orange, text: '0%'),
      Chart(x: 'In Progress', y: 0, color: beg, text: '0%'),
      Chart(
          x: 'Completed',
          y: 0,
          color: const Color.fromARGB(255, 85, 175, 88),
          text: '0%'),
    ];
    int notStarted = 0;
    int inProgress = 0;
    int completed = 0;

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;

      if (data['task_state'] == 'notStarted') {
        notStarted++;
      } else if (data['task_state'] == 'inProgress') {
        inProgress++;
      } else if (data['task_state'] == 'completed') {
        completed++;
      }
    }
    int total = notStarted + inProgress + completed;
    chartData[0].y =
        double.parse(((notStarted / total) * 100).toStringAsFixed(2));
    chartData[0].text =
        double.parse(((notStarted / total) * 100).toStringAsFixed(2))
                .toString() +
            '%';
    chartData[1].y =
        double.parse(((inProgress / total) * 100).toStringAsFixed(2));
    chartData[1].text =
        double.parse(((inProgress / total) * 100).toStringAsFixed(2))
                .toString() +
            '%';
    chartData[2].y =
        double.parse(((completed / total) * 100).toStringAsFixed(2));
    chartData[2].text =
        double.parse(((completed / total) * 100).toStringAsFixed(2))
                .toString() +
            '%';
    return chartData;
  }
}
