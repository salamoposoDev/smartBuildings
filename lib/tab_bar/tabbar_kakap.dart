import 'package:flutter/material.dart';
import 'package:smartbuilding/component/monitor.dart';

class TabKakap extends StatefulWidget {
  const TabKakap({super.key});

  @override
  State<TabKakap> createState() => _TabKakapState();
}

class _TabKakapState extends State<TabKakap> {
  List sensorComponent = [
    ['Voltage', 'lib/icons/volt.png', '220 v'],
    ['Current', 'lib/icons/current.png', '2 A'],
    ['Power', 'lib/icons/power.png', '200 w'],
    ['Energy', 'lib/icons/energy.png', '2100 Kwh'],
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: sensorComponent.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Monitor(
            sensorName: sensorComponent[index][0],
            sensorIcon: sensorComponent[index][1],
            sensorValue: sensorComponent[index][2],
          );
        });
  }
}
