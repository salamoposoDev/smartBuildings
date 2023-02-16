import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smartbuilding/component/monitor.dart';
import 'package:smartbuilding/model/energy.dart';

class TabRumah extends StatefulWidget {
  TabRumah({super.key});

  @override
  State<TabRumah> createState() => _TabRumahState();
}

class _TabRumahState extends State<TabRumah> {
  final String pathRumah = 'buildings/rumah';
  var realtimeData;
  String voltageValue = '0';
  String currentValue = '0';
  String powerValue = '0';
  String energyValue = '0';

  List sensorComponent = [
    // sensorName, SensorIcon, SensorValue
    ['Voltage', 'lib/icons/volt.png', '0 V'],
    ['Current', 'lib/icons/current.png', '0 A'],
    ['Power', 'lib/icons/power.png', '0 W'],
    ['Energy', 'lib/icons/energy.png', '0 kWh'],
  ];

  List _powerSensorData = [];

  @override
  Widget build(BuildContext context) {
    // GET DATA SENSORS
    DatabaseReference powerSensors =
        FirebaseDatabase.instance.ref('$pathRumah/sensors/').child('realtime/');
    powerSensors.onValue.listen((event) {
      realtimeData = event.snapshot.value;
      final parse = jsonEncode(realtimeData);
      log(parse);
    });
    return StreamBuilder(
        stream: powerSensors.onValue,
        builder: (contex, snap) {
          if (snap.hasData &&
              !snap.hasError &&
              snap.data?.snapshot.value != null) {
            // EnergyModel welcomeFromJson(String str) =>
            //     EnergyModel.fromJson(json.decode(str));
            // final welcome =
            //     welcomeFromJson(snap.data!.snapshot.value!.toString());
            // log("${welcome.cosphi.toString()} ok");
            // log("${welcome.cosphi.toString()} siap");

            EnergyModel energyModel = EnergyModel();
            // Sensor Value From database
            List<String> powerRumahValue = [
              '${energyModel.voltage} V',
              '${energyModel.voltage} A',
              '${energyModel.voltage} w',
              '${energyModel.voltage} kWh',
            ];

            // parsing data

            // print(dataPowerRumah);
            return GridView.builder(
                itemCount: sensorComponent.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (contex, index) {
                  return Monitor(
                    sensorName: sensorComponent[index][0],
                    sensorIcon: sensorComponent[index][1],
                    sensorValue: powerRumahValue[index],
                  );
                });
          } else {
            return GridView.builder(
                itemCount: sensorComponent.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (contex, index) {
                  return Monitor(
                    sensorName: sensorComponent[index][0],
                    sensorIcon: sensorComponent[index][1],
                    sensorValue: sensorComponent[index][2],
                  );
                });
          }
        });
  }
}
