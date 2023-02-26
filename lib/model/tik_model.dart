import 'dart:convert';

class Test {
  dynamic current, freq, power, cosphi, energy;
  int? voltage;

  Test({
    this.current,
    this.cosphi,
    this.power,
    this.energy,
    this.voltage,
    this.freq,
  });

  factory Test.fromMap(Map<String, dynamic> data) => Test(
        freq: (data['freq'] as dynamic),
        current: (data['current'] as dynamic),
        cosphi: (data['cosphi'] as dynamic),
        power: (data['power'] as dynamic),
        energy: (data['energy'] as dynamic),
        voltage: data['voltage'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'current': current,
        'cosphi': cosphi,
        'power': power,
        'energy': energy,
        'voltage': voltage,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Test].
  factory Test.fromJson(String data) {
    return Test.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Test] to a JSON string.
  String toJson() => json.encode(toMap());
}
