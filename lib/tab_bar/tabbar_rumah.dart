import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbuilding/component/monitor.dart';

import '../bloc/database_bloc.dart';

// ignore: must_be_immutable
class TabRumah extends StatelessWidget {
  TabRumah({super.key});

  final String pathRumah = 'buildings/rumah';

  List sensorComponent = [
    // sensorName, SensorIcon, SensorValue
    ['Voltage', 'lib/icons/volt.png', '0'],
    ['Current', 'lib/icons/current.png', '0'],
    ['Power', 'lib/icons/power.png', '0'],
    ['Energy', 'lib/icons/energy.png', '0'],
    ['Cosphi', 'lib/icons/phi.png', '0'],
    ['Freq', 'lib/icons/freq.png', '0'],
  ];

  List satuanSensor = [' V', ' A', ' W', ' kWh', '', ' Hz'];

  @override
  Widget build(BuildContext context) {
    // GET DATA SENSORS
    // DatabaseReference powerSensors =
    //     FirebaseDatabase.instance.ref('$pathRumah/sensors/').child('realtime/');
    // powerSensors.onValue.listen((event) {
    //   realtimeData = event.snapshot.value;
    // });
    // print('rebuild');
    return Center(
      child: BlocBuilder<DatabaseBloc, List>(
        builder: (context, state) {
          if (state.isEmpty) {
            return const CircularProgressIndicator();
          }
          return GridView.builder(
              itemCount: sensorComponent.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (contex, index) {
                return Monitor(
                  sensorName: sensorComponent[index][0],
                  sensorIcon: sensorComponent[index][1],
                  sensorValue: state[index],
                  satuan: satuanSensor[index],
                );
              });
        },
      ),
    );
    // return StreamBuilder(
    //     stream: powerSensors.onValue,
    //     builder: (contex, snap) {
    //       if (snap.hasData &&
    //           !snap.hasError &&
    //           snap.data?.snapshot.value != null) {
    //         String stringData = jsonEncode(snap.data?.snapshot.value);
    //         EnergyModel energyModel =
    //             EnergyModel.fromJson(json.decode(stringData));

    //         List valueSensor = [
    //           energyModel.voltage?.toStringAsFixed(0),
    //           energyModel.current.toStringAsFixed(1),
    //           energyModel.power.toStringAsFixed(1),
    //           energyModel.energy.toStringAsFixed(2),
    //           energyModel.cosphi.toStringAsFixed(1),
    //           energyModel.freq.toStringAsFixed(0),
    //         ];

    //         // Sensor Value From database
    //         return GridView.builder(
    //             itemCount: sensorComponent.length,
    //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //                 crossAxisCount: 2),
    //             itemBuilder: (contex, index) {
    //               return Monitor(
    //                 sensorName: sensorComponent[index][0],
    //                 sensorIcon: sensorComponent[index][1],
    //                 sensorValue: valueSensor[index],
    //                 satuan: satuanSensor[index],
    //               );
    //             });
    //       } else {
    //         return GridView.builder(
    //             itemCount: sensorComponent.length,
    //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //                 crossAxisCount: 2),
    //             itemBuilder: (contex, index) {
    //               return Monitor(
    //                 sensorName: sensorComponent[index][0],
    //                 sensorIcon: sensorComponent[index][1],
    //                 sensorValue: sensorComponent[index][2],
    //                 satuan: satuanSensor[index],
    //               );
    //             });
    //       }
    //     });
  }
}
