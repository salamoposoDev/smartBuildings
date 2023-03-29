part of 'realtime_data_bloc.dart';

@immutable
abstract class RealtimeDataState {}

class RealtimeDataInitial extends RealtimeDataState {}

class RealtimeDataLoading extends RealtimeDataState {}

// ignore: must_be_immutable
class RealtimeDataSuccess extends RealtimeDataState {
  EnergyModel energyModel = EnergyModel();
  RealtimeDataSuccess({required this.energyModel});
}
