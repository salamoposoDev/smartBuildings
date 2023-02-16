import 'package:flutter/material.dart';
import 'package:smartbuilding/component/monitor.dart';

class TabSalmon extends StatelessWidget {
  TabSalmon({super.key});

  List sensorComponent = [
    // sensorName, SensorIcon, SensorValue
    ['Voltage', 'lib/icons/volt.png', '220 V'],
    ['Current', 'lib/icons/current.png', '21 A'],
    ['Power', 'lib/icons/power.png', '670 W'],
    ['Energy', 'lib/icons/energy.png', '1200 kWh'],
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 4,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (contex, index) {
          return Monitor(
            sensorName: sensorComponent[index][0],
            sensorIcon: sensorComponent[index][1],
            sensorValue: sensorComponent[index][2],
          );
        });
  }
}
