class Modification {
  String? name;
  num tier;
  num repairCoeff;
  num value;
  num reqExp;
  num geCost;
  String? requiredModification;
  String? modClass;
  String? icon;

  Modification({
    this.name,
    this.tier = 0,
    this.repairCoeff = 0.0,
    this.value = 0,
    this.reqExp = 0,
    this.geCost = 0,
    this.requiredModification,
    this.modClass,
    this.icon,
  });

  factory Modification.fromMap(Map<String, dynamic> map) {
    return Modification(
      name: map['name'],
      tier: map['tier'] ?? 0,
      repairCoeff: map['repair_coeff'] ?? 0.0,
      value: map['value'] ?? 0,
      reqExp: map['req_exp'] ?? 0,
      geCost: map['ge_cost'] ?? 0,
      requiredModification: map['required_modification'],
      modClass: map['mod_class'],
      icon: map['icon'],
    );
  }

  @override
  String toString() {
    return 'Modification: $name, $tier, $repairCoeff, $value, $reqExp, $geCost, $requiredModification';
  }
}
