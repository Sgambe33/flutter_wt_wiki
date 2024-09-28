class BallisticComputer {
  bool hasGunCcip;
  bool hasTurretCcip;
  bool hasBombsCcip;
  bool hasRocketCcip;

  bool hasGunCcrp;
  bool hasTurretCcrp;
  bool hasBombsCcrp;
  bool hasRocketCcrp;

  BallisticComputer({
    this.hasGunCcip = false,
    this.hasTurretCcip = false,
    this.hasBombsCcip = false,
    this.hasRocketCcip = false,
    this.hasGunCcrp = false,
    this.hasTurretCcrp = false,
    this.hasBombsCcrp = false,
    this.hasRocketCcrp = false,
  });

  factory BallisticComputer.fromMap(Map<String, dynamic> map) {
    return BallisticComputer(
      hasGunCcip: map['gun_ccip'] ?? false,
      hasTurretCcip: map['turret_ccip'] ?? false,
      hasBombsCcip: map['bombs_ccip'] ?? false,
      hasRocketCcip: map['rocket_ccip'] ?? false,
      hasGunCcrp: map['gun_ccrp'] ?? false,
      hasTurretCcrp: map['turret_ccrp'] ?? false,
      hasBombsCcrp: map['bombs_ccrp'] ?? false,
      hasRocketCcrp: map['rocket_ccrp'] ?? false,
    );
  }

  @override
  String toString() {
    return 'gun_ccip: $hasGunCcip, turret_ccip: $hasTurretCcip, bombs_ccip: $hasBombsCcip, rocket_ccip: $hasRocketCcip, gun_ccrp: $hasGunCcrp, turret_ccrp: $hasTurretCcrp, bombs_ccrp: $hasBombsCcrp, rocket_ccrp: $hasRocketCcrp';
  }
}
