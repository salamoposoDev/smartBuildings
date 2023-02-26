class SensorStatus {
  int? hTime, b1Time, b2Time, b3Time, b4Time, b5Time;
  dynamic hTotalEnergy,
      b1TotalEnergy,
      b2TotalEnergy,
      b3TotalEnergy,
      b4TotalEnergy,
      b5TotalEnergy;
  String? hSens, b1Sens, b2Sens, b3Sens, b4Sens, b5Sens;

  SensorStatus({
    this.hTotalEnergy,
    this.b1TotalEnergy,
    this.b2TotalEnergy,
    this.b3TotalEnergy,
    this.b4TotalEnergy,
    this.b5TotalEnergy,
    this.hSens,
    this.hTime,
    this.b1Sens,
    this.b1Time,
    this.b2Sens,
    this.b2Time,
    this.b3Sens,
    this.b3Time,
    this.b4Sens,
    this.b4Time,
    this.b5Sens,
    this.b5Time,
  });

  factory SensorStatus.fromJson(Map<String, dynamic> json) => SensorStatus(
        hTotalEnergy: (json['hTotalEnergy'] as dynamic)?.toDouble(),
        hSens: json['hSens'] as String?,
        hTime: json['hTime'] as int?,
        b1TotalEnergy: (json['b1TotalEnergy'] as dynamic)?.toDouble(),
        b1Sens: json['b1Sens'] as String?,
        b1Time: json['b1Time'] as int?,
        b2TotalEnergy: (json['b2TotalEnergy'] as dynamic)?.toDouble(),
        b2Sens: json['b2Sens'] as String?,
        b2Time: json['b2Time'] as int?,
        b3TotalEnergy: (json['b3TotalEnergy'] as dynamic)?.toDouble(),
        b3Sens: json['b3Sens'] as String?,
        b3Time: json['b3Time'] as int?,
        b4TotalEnergy: (json['b4TotalEnergy'] as dynamic)?.toDouble(),
        b4Sens: json['b4Sens'] as String?,
        b4Time: json['b4Time'] as int?,
        b5TotalEnergy: (json['b5TotalEnergy'] as dynamic)?.toDouble,
        b5Sens: json['b5Sens'] as String?,
        b5Time: json['b5Time'] as int?,
      );
}
