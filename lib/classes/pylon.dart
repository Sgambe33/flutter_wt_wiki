import 'package:flutter_wt_wiki/classes/weapon.dart';

class Pylon {
  int index;
  bool usedForDisbalance;
  List<Weapon> selectableWeapons;

  Pylon({
    this.index = 1,
    this.usedForDisbalance = true,
    this.selectableWeapons = const [],
  });

  factory Pylon.fromMap(Map<String, dynamic> map) {
    return Pylon(
      index: map['index'] ?? 1,
      usedForDisbalance: map['used_for_disbalance'] ?? true,
      selectableWeapons: map['selectable_weapons'] != null ? List<Weapon>.from(map['selectable_weapons'].map((x) => Weapon.fromMap(x))) : [],
    );
  }

  @override
  String toString() {
    return 'Pylon: $index, $usedForDisbalance, $selectableWeapons';
  }
}
