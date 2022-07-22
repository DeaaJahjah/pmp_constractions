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

    List<Chart> chartData = [];
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

    if (notStarted != 0) {
      chartData.add(Chart(
          x: 'Not Started',
          y: double.parse(((notStarted / total) * 100).toStringAsFixed(2)),
          color: orange,
          text: double.parse(((notStarted / total) * 100).toStringAsFixed(2))
                  .toString() +
              '%'));
    }
    if (inProgress != 0) {
      chartData.add(Chart(
          x: 'In Progress',
          y: double.parse(((inProgress / total) * 100).toStringAsFixed(2)),
          color: beg,
          text: double.parse(((inProgress / total) * 100).toStringAsFixed(2))
                  .toString() +
              '%'));
    }

    if (completed != 0) {
      chartData.add(Chart(
          x: 'Completed',
          y: double.parse(((completed / total) * 100).toStringAsFixed(2)),
          color: const Color.fromARGB(255, 85, 175, 88),
          text: double.parse(((completed / total) * 100).toStringAsFixed(2))
                  .toString() +
              '%'));
    }

    return chartData;
  }
}
