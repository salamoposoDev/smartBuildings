import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smartbuilding/component/monitor.dart';
import 'package:smartbuilding/model/energy.dart';

class TabRumah extends StatefulWidget {
  const TabRumah({super.key});

  @override
  State<TabRumah> createState() => _TabRumahState();
}

class _TabRumahState extends State<TabRumah> {
  final String pathRumah = 'buildings/rumah';

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
    // GET DATA SENSORS
    DatabaseReference powerSensors =
        FirebaseDatabase.instance.ref('$pathRumah/sensors/').child('realtime/');
    // powerSensors.onValue.listen((event) {
    //   realtimeData = event.snapshot.value;
    // });
    return StreamBuilder(
        stream: powerSensors.onValue,
        builder: (contex, snap) {
          if (snap.hasData &&
              !snap.hasError &&
              snap.data?.snapshot.value != null) {
            String stringData = jsonEncode(snap.data?.snapshot.value);
            EnergyModel energyModel =
                EnergyModel.fromJson(json.decode(stringData));

            // Sensor Value From database
            List<String> powerRumahValue = [
              '${energyModel.voltage} V',
              '${energyModel.current} A',
              '${energyModel.power} w',
              '${energyModel.energy} kWh',
              '${energyModel.cosphi}',
              '${energyModel.freq} Hz',
            ];
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
