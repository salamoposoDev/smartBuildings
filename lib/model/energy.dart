class EnergyModel {
  int? power;
  int? cosphi;
  int? current;
  int? voltage;
  int? energy;

  EnergyModel({
    this.power,
    this.cosphi,
    this.current,
    this.voltage,
    this.energy,
  });

  factory EnergyModel.fromJson(Map<String, dynamic> json) => EnergyModel(
        power: json['power'] as int?,
        cosphi: json['cosphi'] as int?,
        current: json['current'] as int?,
        voltage: json['voltage'] as int?,
        energy: json['energy'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'power': power,
        'cosphi': cosphi,
        'current': current,
        'voltage': voltage,
        'energy': energy,
      };
}
