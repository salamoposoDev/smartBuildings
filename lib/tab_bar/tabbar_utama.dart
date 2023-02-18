import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smartbuilding/component/monitor.dart';
import 'package:smartbuilding/model/g_utama_model.dart';

class TabUtama extends StatefulWidget {
  const TabUtama({super.key});

  @override
  State<TabUtama> createState() => _TabUtamaState();
}

class _TabUtamaState extends State<TabUtama> {
  List sensorComponent = [
    // sensorName, SensorIcon, SensorValue
    ['Voltage', 'lib/icons/volt.png', '220 V'],
    ['Current', 'lib/icons/current.png', '21 A'],
    ['Power', 'lib/icons/power.png', '670 W'],
    ['Energy', 'lib/icons/energy.png', '1200 kWh'],
  ];
  @override
  Widget build(BuildContext context) {
    String path = 'buildings/gedungUtama/sensors/';
    DatabaseReference _refPower =
        FirebaseDatabase.instance.ref('$path').child('realtime/');
    return StreamBuilder(
      stream: _refPower.onValue,
      builder: (context, snap) {
        if (snap.hasData &&
            !snap.hasError &&
            snap.data!.snapshot.value != null) {
          String stringData = jsonEncode(snap.data!.snapshot.value);
          GedungUtamaModel dataSensor =
              GedungUtamaModel.fromJson(json.decode(stringData));

          List<String> sensorList = [
            '${dataSensor.voltage} V',
            '${dataSensor.current} A',
            '${dataSensor.power} W',
            '${dataSensor.energy} kWh',
          ];
          return GridView.builder(
              itemCount: 4,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, Index) {
                return Monitor(
                  sensorName: sensorComponent[Index][0],
                  sensorIcon: sensorComponent[Index][1],
                  sensorValue: sensorList[Index],
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
            },
          );
        }
      },
    );
  }
}
