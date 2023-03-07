class HistoryKwh {
  dynamic energy;
  int? time;

  HistoryKwh({this.energy, this.time});

  factory HistoryKwh.fromJson(Map<String, dynamic> json) => HistoryKwh(
        energy: (json['energy'] as dynamic),
        time: json['time'] as int?,
      );
}
