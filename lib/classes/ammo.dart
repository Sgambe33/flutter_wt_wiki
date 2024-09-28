class Ammo {
  String? name;
  String? type;
  double caliber;
  double mass;
  double speed;
  double maxDistance;
  String? explosiveType;
  double explosiveMass;

  Ammo({
    this.name,
    this.type,
    this.caliber = 0.0,
    this.mass = 0.0,
    this.speed = 0.0,
    this.maxDistance = 0.0,
    this.explosiveType,
    this.explosiveMass = 0.0,
  });

  factory Ammo.fromMap(Map<String, dynamic> map) {
    return Ammo(
      name: map['name'],
      type: map['type'],
      caliber: map['caliber'] ?? 0.0,
      mass: map['mass'] ?? 0.0,
      speed: map['speed'] ?? 0.0,
      maxDistance: map['max_distance'] ?? 0.0,
      explosiveType: map['explosive_type'],
      explosiveMass: map['explosive_mass'] ?? 0.0,
    );
  }

  @override
  String toString() {
    return 'Ammo: $name $type ${caliber}mm, ${mass}kg, ${speed}m/s, ${maxDistance}m, $explosiveType ${explosiveMass}kg';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'caliber': caliber,
      'mass': mass,
      'speed': speed,
      'max_distance': maxDistance,
      'explosive_type': explosiveType,
      'explosive_mass': explosiveMass,
    };
  }
}
