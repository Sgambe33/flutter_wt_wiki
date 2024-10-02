import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_wt_wiki/classes/preset.dart';
import 'package:flutter_wt_wiki/classes/vehicle.dart';
import 'package:flutter_wt_wiki/classes/weapon.dart';

class PresetsWidget extends StatefulWidget {
  final Vehicle dbVehicle;

  const PresetsWidget({super.key, required this.dbVehicle});

  @override
  _PresetsWidgetState createState() => _PresetsWidgetState();
}

class _PresetsWidgetState extends State<PresetsWidget> {
  late Map<String, List<Widget>> rows;
  late Future<void> _initializationFuture;

  @override
  void initState() {
    super.initState();
    _initializationFuture = _initializeRows();
  }

  Future<void> _initializeRows() async {
    int originalColumnCount = widget.dbVehicle.customizablePresets!.pylons.length - 1;
    int columnCount = originalColumnCount;
    if (originalColumnCount % 2 == 0) {
      columnCount += 1;
    }

    rows = {};
    for (int rowIndex = 0; rowIndex < widget.dbVehicle.presets.length; rowIndex++) {
      List<Widget> columns = List.generate(columnCount, (index) => Container(height: 40, width: 40, color: Colors.grey[300]));
      Preset preset = widget.dbVehicle.presets[rowIndex];
      if (preset.weapons.isEmpty) {
        rows["row_$rowIndex"] = columns;
        continue;
      }
      for (int colIndex = 0; colIndex < originalColumnCount; colIndex++) {
        int adjustedColIndex = colIndex;
        if (originalColumnCount % 2 == 0 && colIndex >= originalColumnCount ~/ 2) {
          adjustedColIndex += 1;
        }
        var pylon = widget.dbVehicle.customizablePresets!.pylons[colIndex + 1];
        for (Weapon weapon in preset.weapons) {
          for (Weapon selectableWeapon in pylon.selectableWeapons) {
            if (selectableWeapon.name == weapon.name) {
              columns[adjustedColIndex] = InkWell(onTap: () {}, child: Container(height: 40, width: 40, color: Colors.green, child: Center(child: Text(weapon.name!))));
            }
          }
        }
      }
      rows["row_$rowIndex"] = columns;
    }
  }

  @override
  Widget build(BuildContext context) {
    int originalColumnCount = widget.dbVehicle.customizablePresets!.pylons.length - 1;
    int columnCount = originalColumnCount;
    if (originalColumnCount % 2 == 0) {
      columnCount += 1;
    }

    return ExpansionTile(title: const Text('Presets'), children: [
      FutureBuilder<void>(
          future: _initializationFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading presets'));
            } else {
              return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: IntrinsicWidth(
                      child: IntrinsicHeight(
                          child: LayoutGrid(
                              columnSizes: List.generate(columnCount, (index) => auto),
                              rowSizes: List.generate(widget.dbVehicle.presets.length, (index) => auto),
                              columnGap: 5,
                              rowGap: 5,
                              children: [
                        for (int rowIndex = 0; rowIndex < widget.dbVehicle.presets.length; rowIndex++)
                          for (int colIndex = 0; colIndex < columnCount; colIndex++) rows["row_$rowIndex"]![colIndex].withGridPlacement(columnStart: colIndex, rowStart: rowIndex)
                      ]))));
            }
          })
    ]);
  }
}
