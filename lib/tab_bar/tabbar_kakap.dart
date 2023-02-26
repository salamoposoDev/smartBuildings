import 'package:flutter/material.dart';
import 'package:smartbuilding/component/monitor.dart';

class TabKakap extends StatefulWidget {
  const TabKakap({super.key});

  @override
  State<TabKakap> createState() => _TabKakapState();
}

class _TabKakapState extends State<TabKakap> {
  List sensorComponent = [
    // sensorName, SensorIcon, SensorValue
    ['Voltage', 'lib/icons/volt.png', '0 V'],
    ['Current', 'lib/icons/current.png', '0 A'],
    ['Power', 'lib/icons/power.png', '0 W'],
    ['Energy', 'lib/icons/energy.png', '0 kWh'],
    ['Cosphi', 'lib/icons/phi.png', '0'],
    ['Freq', 'lib/icons/freq.png', '0 Hz'],
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: sensorComponent.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Monitor(
            sensorName: sensorComponent[index][0],
            sensorIcon: sensorComponent[index][1],
            sensorValue: sensorComponent[index][2],
          );
        });
  }
}
