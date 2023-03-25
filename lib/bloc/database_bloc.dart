import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbuilding/model/energy.dart';

class DatabaseBloc extends Cubit<List> {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref('buildings/rumah/sensors/realtime');
  DatabaseBloc() : super([]) {
    _dbRef.onValue.listen((event) {
      final value = event.snapshot.value;
      String stringData = jsonEncode(value).toString();
      EnergyModel energyModel = EnergyModel.fromJson(json.decode(stringData));
      List datalist = [
        energyModel.voltage!.toStringAsFixed(0),
        energyModel.current.toStringAsFixed(2),
        energyModel.power.toStringAsFixed(2),
        energyModel.energy.toStringAsFixed(2),
        energyModel.cosphi.toStringAsFixed(1),
        energyModel.freq.toStringAsFixed(0),
      ];
      // print(datalist);
      emit(datalist);
    });
  }
}
