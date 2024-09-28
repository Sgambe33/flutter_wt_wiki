import 'package:flutter_wt_wiki/classes/pylon.dart';

class CustomizablePreset {
  num maxLoad;
  num maxLoadLeftWing;
  num maxLoadRightWing;
  num maxDisbalance;
  List<Pylon> pylons;

  CustomizablePreset({
    this.maxLoad = 0,
    this.maxLoadLeftWing = 0,
    this.maxLoadRightWing = 0,
    this.maxDisbalance = 0,
    this.pylons = const [],
  });

  factory CustomizablePreset.fromMap(Map<String, dynamic> map) {
    return CustomizablePreset(
      maxLoad: map['max_load'] ?? 0,
      maxLoadLeftWing: map['max_load_left_wing'] ?? 0,
      maxLoadRightWing: map['max_load_right_wing'] ?? 0,
      maxDisbalance: map['max_disbalance'] ?? 0,
      pylons: map['pylons'] != null ? List<Pylon>.from(map['pylons'].map((x) => Pylon.fromMap(x))) : [],
    );
  }

  @override
  String toString() {
    return 'Custom preset: $maxLoad, $maxLoadLeftWing, $maxLoadRightWing, $maxDisbalance, $pylons';
  }
}
