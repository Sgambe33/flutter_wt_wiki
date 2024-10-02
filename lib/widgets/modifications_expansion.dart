import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_wt_wiki/classes/modification.dart';

class ModificationsExpansion extends StatefulWidget {
  final Map<String, dynamic>? data;
  const ModificationsExpansion({super.key, this.data});

  @override
  _ModificationsExpansionState createState() => _ModificationsExpansionState();
}

class _ModificationsExpansionState extends State<ModificationsExpansion> {
  List<Modification>? modifications;

  Future<void> loadJson() async {
    final String response = await rootBundle.loadString('assets/fakevehicles/a6m2.json');
    final data = await json.decode(response);
    setState(() {
      modifications = List<Modification>.from(data['modifications'].map((x) => Modification.fromMap(x)));
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
                  columnSizes: List.generate(5, (_) => auto),
                  rowSizes: List.generate(1, (_) => auto),
                  columnGap: 10,
                  rowGap: 2,
                  children: const [
                    GridPlacement(columnStart: 0, columnSpan: 2, rowStart: 0, child: Text("Flight performance")),
                  ],
                ),
                LayoutGrid(
                  columnSizes: List.generate(5, (_) => auto),
                  rowSizes: List.generate(1, (_) => auto),
                  columnGap: 10,
                  rowGap: 2,
                  children: const [
                    GridPlacement(columnStart: 0, columnSpan: 2, rowStart: 0, child: Text("Survivability")),
                  ],
                ),
                LayoutGrid(
                  columnSizes: List.generate(5, (_) => auto),
                  rowSizes: List.generate(1, (_) => auto),
                  columnGap: 10,
                  rowGap: 2,
                  children: const [
                    GridPlacement(columnStart: 0, columnSpan: 2, rowStart: 0, child: Text("Weaponry")),
                  ],
                ),
              ],
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
