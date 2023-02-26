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
    ['Voltage', 'lib/icons/volt.png', '0 V'],
    ['Current', 'lib/icons/current.png', '0 A'],
    ['Power', 'lib/icons/power.png', '0 W'],
    ['Energy', 'lib/icons/energy.png', '0 kWh'],
    ['Cosphi', 'lib/icons/phi.png', '0'],
    ['Freq', 'lib/icons/freq.png', '0 Hz'],
  ];
  @override
  Widget build(BuildContext context) {
    String path = 'buildings/gedungUtama/sensors/';
    DatabaseReference refPower =
        FirebaseDatabase.instance.ref(path).child('realtime/');
    return StreamBuilder(
      stream: refPower.onValue,
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
            '${dataSensor.cosphi}',
            '${dataSensor.freq} Hz',
          ];
          return GridView.builder(
              itemCount: sensorComponent.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Monitor(
                  sensorName: sensorComponent[index][0],
                  sensorIcon: sensorComponent[index][1],
                  sensorValue: sensorList[index],
                );
              });
        } else {
          return GridView.builder(
            itemCount: sensorComponent.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
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
