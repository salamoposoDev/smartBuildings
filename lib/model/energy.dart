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
        freq: (json['freq'] as dynamic),
        power: (json['power'] as dynamic),
        cosphi: (json['cosphi'] as dynamic),
        current: (json['current'] as dynamic),
        voltage: json['voltage'] as int?,
        energy: (json['energy'] as dynamic),
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
