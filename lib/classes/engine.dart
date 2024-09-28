class Engine {
  num horsePowerAb;
  num horsePowerRbSb;
  num maxRpm;
  num minRpm;
  num maxSpeedAb;
  num maxReverseSpeedAb;
  num maxSpeedRbSb;
  num maxReverseSpeedRbSb;

  Engine({
    this.horsePowerAb = 0,
    this.horsePowerRbSb = 0,
    this.maxRpm = 0,
    this.minRpm = 0,
    this.maxSpeedAb = 0,
    this.maxReverseSpeedAb = 0,
    this.maxSpeedRbSb = 0,
    this.maxReverseSpeedRbSb = 0,
  });

  factory Engine.fromMap(Map<String, dynamic> map) {
    return Engine(
      horsePowerAb: map['horse_power_ab'] ?? 0,
      horsePowerRbSb: map['horse_power_rb_sb'] ?? 0,
      maxRpm: map['max_rpm'] ?? 0,
      minRpm: map['min_rpm'] ?? 0,
      maxSpeedAb: map['max_speed_ab'] ?? 0,
      maxReverseSpeedAb: map['max_reverse_speed_ab'] ?? 0,
      maxSpeedRbSb: map['max_speed_rb_sb'] ?? 0,
      maxReverseSpeedRbSb: map['max_reverse_speed_rb_sb'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Engine: $horsePowerAb HP (AB), $horsePowerRbSb HP (RB/SB), $maxRpm RPM, $minRpm RPM, $maxSpeedAb km/h (AB), $maxReverseSpeedAb km/h (AB), $maxSpeedRbSb km/h (RB/SB), $maxReverseSpeedRbSb km/h (RB/SB)';
  }
}
