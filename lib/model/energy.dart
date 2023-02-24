class EnergyModel {
  int? voltage;
  // ignore: prefer_typing_uninitialized_variables
  var current, power, energy, cosphi;

  EnergyModel({
    this.power,
    this.cosphi,
    this.current,
    this.voltage,
    this.energy,
  });

  factory EnergyModel.fromJson(Map<String, dynamic> json) => EnergyModel(
        power: (json['power'] as dynamic?)?.toDouble(),
        cosphi: (json['cosphi'] as dynamic?)?.toDouble(),
        current: (json['current'] as dynamic?)?.toDouble(),
        voltage: json['voltage'] as int?,
        energy: (json['energy'] as dynamic?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'power': power,
        'cosphi': cosphi,
        'current': current,
        'voltage': voltage,
        'energy': energy,
      };
}
