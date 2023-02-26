class EnergyModel {
  int? voltage;
  dynamic current, power, energy, cosphi, freq;

  EnergyModel({
    this.freq,
    this.power,
    this.cosphi,
    this.current,
    this.voltage,
    this.energy,
  });

  factory EnergyModel.fromJson(Map<String, dynamic> json) => EnergyModel(
        freq: (json['freq'] as dynamic)?.toDouble(),
        power: (json['power'] as dynamic)?.toDouble(),
        cosphi: (json['cosphi'] as dynamic)?.toDouble(),
        current: (json['current'] as dynamic)?.toDouble(),
        voltage: json['voltage'] as int?,
        energy: (json['energy'] as dynamic)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'power': power,
        'cosphi': cosphi,
        'current': current,
        'voltage': voltage,
        'energy': energy,
        'freq': freq,
      };
}
