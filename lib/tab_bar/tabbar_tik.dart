import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smartbuilding/component/monitor.dart';
import 'package:smartbuilding/model/tik_model.dart';

class TabTik extends StatefulWidget {
  const TabTik({super.key});

  @override
  State<TabTik> createState() => _TabTikState();
}

class _TabTikState extends State<TabTik> {
  List sensorComponent = [
    // sensorName, SensorIcon, SensorValue
    ['Voltage', 'lib/icons/volt.png', '220 V'],
    ['Current', 'lib/icons/current.png', '21 A'],
    ['Power', 'lib/icons/power.png', '670 W'],
    ['Energy', 'lib/icons/energy.png', '1200 kWh'],
  ];

  @override
  Widget build(BuildContext context) {
    String path = 'buildings/gedungTik/sensors/';
    DatabaseReference _refSensors =
        FirebaseDatabase.instance.ref('$path').child('realtime/');
    // _refSensors.onValue.listen((event) {
    //   var realtimeData = event.snapshot.value;
    //   stringData = jsonEncode(event.snapshot.value);
    //   print(stringData);
    //   test = Test.fromMap(json.decode(stringData));
    //   print(test.voltage);
    //   list = [
    //     '${test.voltage} V',
    //     '${test.voltage} V',
    //     '${test.voltage} V',
    //     '${test.voltage} V',
    //   ];
    // });

    return StreamBuilder(
      stream: _refSensors.onValue,
      builder: (context, snap) {
        if (snap.hasData &&
            !snap.hasError &&
            snap.data?.snapshot.value != null) {
          String stringData = jsonEncode(snap.data?.snapshot.value);
          Test test = Test.fromMap(json.decode(stringData));
          List<String> listValue = [
            '${test.voltage} V',
            '${test.current} A',
            '${test.power} W',
            '${test.energy} kWh',
          ];
          return GridView.builder(
              itemCount: sensorComponent.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Monitor(
                  sensorName: sensorComponent[index][0],
                  sensorIcon: sensorComponent[index][1],
                  sensorValue: listValue[index],
                );
              });
        } else {
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
      },
    );
  }
}
