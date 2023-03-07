// To parse this JSON data, do
//
//     final historyData = historyDataFromJson(jsonString);

import 'dart:convert';

Map<String, HistoryData> historyDataFromJson(String str) =>
    Map.from(json.decode(str)).map(
        (k, v) => MapEntry<String, HistoryData>(k, HistoryData.fromJson(v)));

String historyDataToJson(Map<String, HistoryData> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class HistoryData {
  HistoryData({
    required this.cosphi,
    required this.energy,
    required this.current,
    required this.time,
    required this.voltage,
    required this.freq,
    required this.power,
  });

  dynamic cosphi;
  dynamic energy;
  dynamic current;
  int? time;
  int? voltage;
  dynamic freq;
  dynamic power;

  factory HistoryData.fromJson(Map<String, dynamic> json) => HistoryData(
        cosphi: (json["cosphi"] as dynamic),
        energy: (json["energy"] as dynamic),
        current: (json["current"] as dynamic),
        time: json["time"] as int?,
        voltage: json["voltage"] as int?,
        freq: (json["freq"] as dynamic),
        power: (json["power"] as dynamic),
      );

  Map<String, dynamic> toJson() => {
        "cosphi": cosphi,
        "energy": energy,
        "current": current,
        "time": time,
        "voltage": voltage,
        "freq": freq,
        "power": power,
      };
}
