import 'dart:convert';

class Test {
  double? current;
  int? cosphi;
  int? power;
  int? energy;
  int? voltage;

  Test({this.current, this.cosphi, this.power, this.energy, this.voltage});

  factory Test.fromMap(Map<String, dynamic> data) => Test(
        current: (data['current'] as num?)?.toDouble(),
        cosphi: data['cosphi'] as int?,
        power: data['power'] as int?,
        energy: data['energy'] as int?,
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
