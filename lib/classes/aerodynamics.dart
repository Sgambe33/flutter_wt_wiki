class Aerodynamics {
  num length;
  num wingspan;
  num wingArea;
  num emptyWeight;
  num maxTakeoffWeight;
  num maxAltitude;
  num turnTime;
  num runwayLengthRequired;
  num maxSpeedAtAltitude;

  Aerodynamics({
    this.length = 0.0,
    this.wingspan = 0.0,
    this.wingArea = 0.0,
    this.emptyWeight = 0,
    this.maxTakeoffWeight = 0,
    this.maxAltitude = 0,
    this.turnTime = 0,
    this.runwayLengthRequired = 0,
    this.maxSpeedAtAltitude = 0,
  });

  factory Aerodynamics.fromMap(Map<String, dynamic> map) {
    return Aerodynamics(
      length: map['length'] ?? 0.0,
      wingspan: map['wingspan'] ?? 0.0,
      wingArea: map['wing_area'] ?? 0.0,
      emptyWeight: map['empty_weight'] ?? 0,
      maxTakeoffWeight: map['max_takeoff_weight'] ?? 0,
      maxAltitude: map['max_altitude'] ?? 0,
      turnTime: map['turn_time'] ?? 0,
      runwayLengthRequired: map['runway_length_required'] ?? 0,
      maxSpeedAtAltitude: map['max_speed_at_altitude'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Aerodynamics: $length m, $wingspan m, $wingArea m², $emptyWeight kg, $maxTakeoffWeight kg, $maxAltitude m, $turnTime s, $runwayLengthRequired m, $maxSpeedAtAltitude km/h';
  }

  Map<String, dynamic> toJson() {
    return {
      'length': length,
      'wingspan': wingspan,
      'wing_area': wingArea,
      'empty_weight': emptyWeight,
      'max_takeoff_weight': maxTakeoffWeight,
      'max_altitude': maxAltitude,
      'turn_time': turnTime,
      'runway_length_required': runwayLengthRequired,
      'max_speed_at_altitude': maxSpeedAtAltitude,
    };
  }
}
