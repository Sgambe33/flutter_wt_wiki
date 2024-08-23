import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class Modification {
  String? name;
  int? tier;
  double? repair_coeff;
  double? value;
  double? req_exp;
  double? ge_cost;
  String? required_modification;
  String? mod_class;
  String? icon;

  Modification.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    tier = json['tier'] as int?;
    repair_coeff = (json['repair_coeff'] as num?)?.toDouble();
    value = (json['value'] as num?)?.toDouble();
    req_exp = (json['req_exp'] as num?)?.toDouble();
    ge_cost = (json['ge_cost'] as num?)?.toDouble();
    required_modification = json['required_modification'] as String?;
    mod_class = json['mod_class'] as String?;
    icon = json['icon'] as String?;
  }
}

class ModificationsExpansion extends StatefulWidget {
  const ModificationsExpansion({super.key});

  @override
  _ModificationsExpansionState createState() => _ModificationsExpansionState();
}

class _ModificationsExpansionState extends State<ModificationsExpansion> {
  List<Modification>? modifications;
  Map<String, Map<int, int>>? gruppo;

  int getRowCount() {
    int maxTier = 0;
    for (var mod in modifications!) {
      if (mod.tier! > maxTier) {
        maxTier = mod.tier!;
      }
    }
    return maxTier;
  }

  int getColumnCount() {
    List<int> tierCount = List.generate(getRowCount(), (_) => 0);
    for (var mod in modifications!) {
      if (mod.tier! > 0) {
        tierCount[mod.tier! - 1]++;
      }
    }
    return tierCount
        .reduce((value, element) => value > element ? value : element);
  }

  Map<String, List<Modification>> groupByModClass() {
    Map<String, List<Modification>> groupByModClass = {};
    for (Modification mod in modifications!) {
      if (groupByModClass[mod.mod_class!] == null) {
        groupByModClass[mod.mod_class!] = [];
      }
      groupByModClass[mod.mod_class!] = [
        ...groupByModClass[mod.mod_class!]!,
        mod
      ];
    }
    return groupByModClass;
  }

  Map<String, Map<int, List<Modification>>> groupByModClassAndTier() {
    Map<String, Map<int, List<Modification>>> groupByModClassAndTier = {};
    Map<String, List<Modification>> groupByModClassResult = groupByModClass();

    for (String modClass in groupByModClassResult.keys) {
      Map<int, List<Modification>> tierMap = {};
      for (Modification mod in groupByModClassResult[modClass]!) {
        if (tierMap[mod.tier!] == null) {
          tierMap[mod.tier!] = [];
        }
        tierMap[mod.tier!] = [...tierMap[mod.tier!]!, mod];
      }
      groupByModClassAndTier[modClass] = tierMap;
    }
    return groupByModClassAndTier;
  }

  Future<void> loadJson() async {
    final String response =
        await rootBundle.loadString('assets/fakevehicles/a6m2.json');
    final data = await json.decode(response);
    setState(() {
      modifications = List<Modification>.from(
          data['modifications'].map((x) => Modification.fromJson(x)));
      print(groupByModClassAndTier());
      print(getColumnCount());
      print(getRowCount());
    });
  }

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  @override
  Widget build(BuildContext context) {
    return modifications != null
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                LayoutGrid(
                  columnSizes:
                      List.generate(getColumnCount() + 10, (_) => auto),
                  rowSizes: List.generate(getRowCount() + 1, (_) => auto),
                  columnGap: 10,
                  rowGap: 2,
                  children: [
                    GridPlacement(
                        columnStart: 0,
                        columnSpan: 2,
                        rowStart: 0,
                        child: Text("Flight performance")),
                    GridPlacement(
                        columnStart: 2,
                        rowStart: 0,
                        child: Text("Survivability")),
                    GridPlacement(
                      columnStart: 3,
                      rowStart: 0,
                      child: Text("Weaponry",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red)),
                    ),
                    /////////////////////////////////////////
                    GridPlacement(
                      columnStart: 0,
                      rowStart: 1,
                      child: Image.asset(
                        "assets/modifications/aerodinamic_fuse.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    GridPlacement(
                      columnStart: 1,
                      rowStart: 1,
                      child: Image.asset(
                        "assets/modifications/radiator.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    GridPlacement(
                      columnStart: 3,
                      rowStart: 1,
                      child: Image.asset(
                        "assets/modifications/ammo.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    /////////////////////////////////////////
                    GridPlacement(
                      columnStart: 0,
                      rowStart: 2,
                      child: Image.asset(
                        "assets/modifications/compressor.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    GridPlacement(
                      columnStart: 2,
                      rowStart: 2,
                      child: Image.asset(
                        "assets/modifications/armor_frame.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    GridPlacement(
                      columnStart: 3,
                      rowStart: 2,
                      child: Image.asset(
                        "assets/modifications/weapon.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    /////////////////////////////////////////
                    GridPlacement(
                      columnStart: 0,
                      rowStart: 3,
                      child: Image.asset(
                        "assets/modifications/aerodinamic_wing.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    GridPlacement(
                      columnStart: 1,
                      rowStart: 3,
                      child: Image.asset(
                        "assets/modifications/new_engine.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    GridPlacement(
                      columnStart: 2,
                      rowStart: 3,
                      child: Image.asset(
                        "assets/modifications/jet_engine_extinguisher.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    GridPlacement(
                      columnStart: 3,
                      rowStart: 3,
                      child: Image.asset(
                        "assets/modifications/ammo.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    /////////////////////////////////////////
                    GridPlacement(
                      columnStart: 0,
                      rowStart: 4,
                      child: InkWell(
                        child: Image.asset(
                          "assets/modifications/metanol.png",
                          height: 50,
                          width: 50,
                        ),
                        splashColor: Colors.red,
                        enableFeedback: true,
                        onTap: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("Metanol")));
                        },
                      ),
                    ),
                    GridPlacement(
                      columnStart: 2,
                      rowStart: 4,
                      child: Image.asset(
                        "assets/modifications/armor_cover.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    GridPlacement(
                      columnStart: 3,
                      rowStart: 4,
                      child: Image.asset(
                        "assets/modifications/weapon.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    GridPlacement(
                      columnStart: 4,
                      rowStart: 4,
                      child: Image.asset(
                        "assets/modifications/weapon.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    GridPlacement(
                      columnStart: 5,
                      rowStart: 4,
                      child: Image.asset(
                        "assets/modifications/weapon.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    GridPlacement(
                      columnStart: 6,
                      rowStart: 4,
                      child: Image.asset(
                        "assets/modifications/weapon.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    GridPlacement(
                      columnStart: 7,
                      rowStart: 4,
                      child: Image.asset(
                        "assets/modifications/weapon.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
