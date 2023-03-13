import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smartbuilding/component/buiding1_comp.dart';
import 'package:smartbuilding/model/b1_model.dart';

// ignore: must_be_immutable
class TabSalmon extends StatefulWidget {
  const TabSalmon({super.key});

  @override
  State<TabSalmon> createState() => _TabSalmonState();
}

class _TabSalmonState extends State<TabSalmon> {
  List sensorComponent = [
    // sensorName, SensorIcon, SensorValue
    ['Voltage', 'lib/icons/volt.png', '0 V'],
    ['Current', 'lib/icons/current.png', '0 A'],
    ['Power', 'lib/icons/power.png', '0 W'],
    ['Energy', 'lib/icons/energy.png', '0 kWh'],
    ['Cosphi', 'lib/icons/phi.png', '0'],
    ['Freq', 'lib/icons/freq.png', '0 Hz'],
  ];

  List sensorValue = [
    // R,     S,      T
    ['0 V', '0 V', '0 V'],
    ['0 A', '0 A', '0 A'],
    ['0 W', '0 W', '0 W'],
    ['0 kWH', '0 KWH', '0 KWH'],
    ['0', '0', '0'],
    ['0 Hz', '0 HZ', '0 HZ'],
  ];

  List satuan = [
    // R,     S,      T
    'V',
    'A',
    'W',
    'kWh',
    '',
    'Hz'
  ];

  @override
  Widget build(BuildContext context) {
    DatabaseReference b1Ref =
        FirebaseDatabase.instance.ref('buildings/building1/sensors/realtime/');
    return StreamBuilder(
      stream: b1Ref.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            !snapshot.hasError &&
            snapshot.data?.snapshot.value != null) {
          String stringData = jsonEncode(snapshot.data?.snapshot.value);
          B1Realtime jsonResponse =
              B1Realtime.fromJson(json.decode(stringData));

          List dataRealtime = [
            [
              jsonResponse.voltageR?.toStringAsFixed(0),
              jsonResponse.voltageS?.toStringAsFixed(0),
              jsonResponse.voltageT?.toStringAsFixed(0),
            ],
            [
              jsonResponse.currentR.toStringAsFixed(1),
              jsonResponse.currentS.toStringAsFixed(1),
              jsonResponse.currentT.toStringAsFixed(1)
            ],
            [
              jsonResponse.powerR.toStringAsFixed(1),
              jsonResponse.powerS.toStringAsFixed(1),
              jsonResponse.powerT.toStringAsFixed(1),
            ],
            [
              jsonResponse.energyR.toStringAsFixed(2),
              jsonResponse.energyS.toStringAsFixed(2),
              jsonResponse.energyT.toStringAsFixed(2),
            ],
            [
              jsonResponse.cosphiR.toStringAsFixed(1),
              jsonResponse.cosphiS.toStringAsFixed(1),
              jsonResponse.cosphiT.toStringAsFixed(1),
            ],
            [
              jsonResponse.freqR.toStringAsFixed(0),
              jsonResponse.freqS.toStringAsFixed(0),
              jsonResponse.freqT.toStringAsFixed(0),
            ],
          ];

          return GridView.builder(
              itemCount: sensorComponent.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (contex, index) {
                return B1Comp(
                  sensorName: sensorComponent[index][0],
                  sensorIcon: sensorComponent[index][1],
                  sensorValueR: dataRealtime[index][0],
                  sensorValueS: dataRealtime[index][1],
                  sensorValueT: dataRealtime[index][2],
                  satuanSens: satuan[index],
                );
              });
        } else {
          return GridView.builder(
              itemCount: sensorComponent.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (contex, index) {
                return B1Comp(
                  sensorName: sensorComponent[index][0],
                  sensorIcon: sensorComponent[index][1],
                  sensorValueR: sensorValue[index][0],
                  sensorValueS: sensorValue[index][1],
                  sensorValueT: sensorValue[index][2],
                  satuanSens: satuan[index],
                );
              });
        }
      },
    );
  }
}
