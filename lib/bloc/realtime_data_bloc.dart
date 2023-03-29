// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:smartbuilding/model/energy.dart';

part 'realtime_data_event.dart';
part 'realtime_data_state.dart';

class RealtimeDataBloc extends Bloc<RealtimeDataEvent, RealtimeDataState> {
  RealtimeDataBloc() : super(RealtimeDataInitial()) {
    on<RealtimeDataEvent>((event, emit) async {
      emit(RealtimeDataLoading());
      final realtimeDataRef =
          FirebaseDatabase.instance.ref('buildings/rumah/sensors/realtime');
      realtimeDataRef.onValue.listen((event) async {
        if (event.snapshot.exists) {
          String data = jsonEncode(event.snapshot.value);
          var dataSensor = EnergyModel.fromJson(json.decode(data));
          // print(dataSensor.power);
          emit(RealtimeDataSuccess(energyModel: dataSensor));
        }
      });
    });
  }
}
