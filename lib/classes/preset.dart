import 'package:flutter_wt_wiki/classes/weapon.dart';

class Preset {
  String? name;
  List<Weapon> weapons;

  Preset({
    this.name,
    this.weapons = const [],
  });

  factory Preset.fromMap(Map<String, dynamic> map) {
    return Preset(
      name: map['name'],
      weapons: map['weapons'] != null ? List<Weapon>.from(map['weapons'].map((x) => Weapon.fromMap(x))) : [],
    );
  }

  @override
  String toString() {
    return 'Preset: $name, $weapons';
  }
}
