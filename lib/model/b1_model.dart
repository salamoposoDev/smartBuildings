class B1Realtime {
  int? voltageR, voltageS, voltageT, timeR, timeS, timeT;
  dynamic currentR, currentS, currentT;
  dynamic powerR, powerS, powerT;
  dynamic energyR, energyS, energyT;
  dynamic freqR, freqS, freqT;
  dynamic cosphiR, cosphiS, cosphiT;

  B1Realtime({
    this.voltageR,
    this.voltageS,
    this.voltageT,
    this.currentR,
    this.currentS,
    this.currentT,
    this.powerR,
    this.powerS,
    this.powerT,
    this.energyR,
    this.energyS,
    this.energyT,
    this.freqR,
    this.freqS,
    this.freqT,
    this.cosphiT,
    this.cosphiR,
    this.cosphiS,
    this.timeR,
    this.timeS,
    this.timeT,
  });

  factory B1Realtime.fromJson(Map<String, dynamic> json) => B1Realtime(
        voltageR: json['voltageR'] as int?,
        voltageS: json['voltageS'] as int?,
        voltageT: json['voltageT'] as int?,
        currentR: (json['currentR'] as dynamic),
        currentS: (json['currentS'] as dynamic),
        currentT: (json['currentT'] as dynamic),
        powerR: (json['powerR'] as dynamic),
        powerS: (json['powerS'] as dynamic),
        powerT: (json['powerT'] as dynamic),
        energyR: (json['energyR'] as dynamic),
        energyS: (json['energyS'] as dynamic),
        energyT: (json['energyT'] as dynamic),
        freqR: (json['freqR'] as dynamic),
        freqS: (json['freqS'] as dynamic),
        freqT: (json['freqT'] as dynamic),
        cosphiR: (json['cosphiR' as dynamic]),
        cosphiS: (json['cosphiS'] as dynamic),
        cosphiT: (json['cosphiT'] as dynamic),
        timeR: json['timeR'] as int?,
        timeS: json['timerS'] as int?,
        timeT: json['timerT'] as int?,
      );
}
