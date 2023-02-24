class SensorStatus {
  int? hTime, hMcu, hSens;
  int? b1Time, b1Mcu, b1Sens;
  int? b2Time, b2Mcu, b2Sens;
  int? b3Time, b3Mcu, b3Sens;
  int? b4Time, b4Mcu, b4Sens;
  int? b5Time, b5Mcu, b5Sens;

  SensorStatus({
    this.hMcu,
    this.hSens,
    this.hTime,
    this.b1Mcu,
    this.b1Sens,
    this.b1Time,
    this.b2Mcu,
    this.b2Sens,
    this.b2Time,
    this.b3Mcu,
    this.b3Sens,
    this.b3Time,
    this.b4Mcu,
    this.b4Sens,
    this.b4Time,
    this.b5Mcu,
    this.b5Sens,
    this.b5Time,
  });

  factory SensorStatus.fromJson(Map<String, dynamic> json) => SensorStatus(
        hMcu: json['hMcu'] as int?,
        hSens: json['hSens'] as int?,
        hTime: json['hTime'] as int?,
        b1Mcu: json['b1Mcu'] as int?,
        b1Sens: json['b1Sens'] as int?,
        b1Time: json['b1Time'] as int?,
        b2Mcu: json['b2Mcu'] as int?,
        b2Sens: json['b2Sens'] as int?,
        b2Time: json['b2Time'] as int?,
        b3Mcu: json['b3Mcu'] as int?,
        b3Sens: json['b3Sens'] as int?,
        b3Time: json['b3Time'] as int?,
        b4Mcu: json['b4Mcu'] as int?,
        b4Sens: json['b4Sens'] as int?,
        b4Time: json['b4Time'] as int?,
        b5Mcu: json['b5Mcu'] as int?,
        b5Sens: json['b5Sens'] as int?,
        b5Time: json['b5Time'] as int?,
      );
}
