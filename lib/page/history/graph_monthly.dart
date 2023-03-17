import 'package:flutter/material.dart';
import 'package:smartbuilding/graph/bar_graph.dart';

class MonthGraph extends StatefulWidget {
  const MonthGraph({super.key});

  @override
  State<MonthGraph> createState() => _DayGraphState();
}

class _DayGraphState extends State<MonthGraph> {
  List<double> monthlySumarry = [
    7.20,
    6.20,
    5.20,
    4.20,
    3.20,
    2.20,
    1.20,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: MyBarGraph(
            weeklySummary: monthlySumarry,
          ),
        ),
      ],
    );
  }
}
