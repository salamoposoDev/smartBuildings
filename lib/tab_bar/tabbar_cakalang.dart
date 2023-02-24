import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smartbuilding/component/monitor.dart';

class TabCakalang extends StatelessWidget {
  const TabCakalang({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseReference ref_sensor =
        FirebaseDatabase.instance.ref('buildings/cakalang/sensors/realtime/');
    return GridView.builder(
        itemCount: 4,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Monitor(
            sensorName: "Name",
            sensorIcon: "lib/icons/energy.png",
            sensorValue: "value",
          );
        });
  }
}
