import 'package:flutter/material.dart';

class Chart {
  final String x;
  double y;
  final Color color;
  String text;

  Chart(
      {required this.x,
      required this.y,
      required this.color,
      required this.text});
}

// final List<Chart> chartData = [
//   Chart(x: 'Not Started', y: 25, color: orange),
//   Chart(x: 'In Progress', y: 38, color: beg),
//   Chart(x: 'Completed', y: 34, color: const Color.fromARGB(255, 85, 175, 88)),
// ];
