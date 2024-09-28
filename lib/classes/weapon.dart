import 'package:flutter_wt_wiki/classes/ammo.dart';

class Weapon {
  String? name;
  String? weaponType;
  num count;
  List<Ammo> ammos;

  Weapon({
    this.name,
    this.weaponType,
    this.count = 1,
    this.ammos = const [],
  });

  factory Weapon.fromMap(Map<String, dynamic> map) {
    return Weapon(
      name: map['name'],
      weaponType: map['weapon_type'],
      count: map['count'] ?? 1,
      ammos: map['ammos'] != null ? List<Ammo>.from(map['ammos'].map((x) => Ammo.fromMap(x))) : [],
    );
  }

  @override
  String toString() {
    return 'Weapon: $name, $weaponType, $count,\n${ammos.map((i) => '\t${i.toString()}').join('\n')}';
  }
}
