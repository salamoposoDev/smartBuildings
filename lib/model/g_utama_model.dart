class GedungUtamaModel {
  int? voltage;
  dynamic current, freq, power, cosphi, energy;

  GedungUtamaModel({
    this.freq,
    this.voltage,
    this.current,
    this.power,
    this.energy,
    this.cosphi,
  });

  factory GedungUtamaModel.fromJson(Map<String, dynamic> json) =>
      GedungUtamaModel(
        voltage: json['voltage'] as int?,
        current: (json['current'] as dynamic),
        power: (json['power'] as dynamic),
        energy: (json['energy'] as dynamic),
        freq: (json['freq'] as dynamic),
        cosphi: (json['cosphi'] as dynamic),
      );
}
