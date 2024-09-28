class SyntheticVehicle{
  String? country;
  String? identifier;
  String? vehicleType;
  num era;

  SyntheticVehicle({
    this.country,
    this.identifier,
    this.vehicleType,
    this.era = 1,
  });

  factory SyntheticVehicle.fromMap(Map<String, dynamic> map) {
    return SyntheticVehicle(
      country: map['country'],
      identifier: map['identifier'],
      vehicleType: map['vehicle_type'],
      era: map['era'] ?? 1,
    );
  }
}