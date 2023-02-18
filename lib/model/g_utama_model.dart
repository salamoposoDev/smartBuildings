class GedungUtamaModel {
  int? voltage, power, energy, cosphi;
  double? current;

  GedungUtamaModel({
    this.voltage,
    this.current,
    this.power,
    this.energy,
    this.cosphi,
  });

  factory GedungUtamaModel.fromJson(Map<String, dynamic> json) =>
      GedungUtamaModel(
        voltage: json['voltage'] as int?,
        current: (json['current'] as num?)?.toDouble(),
        power: json['power'] as int?,
        energy: json['energy'] as int?,
      );
}
