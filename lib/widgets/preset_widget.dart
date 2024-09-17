import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class PresetsWidget extends StatefulWidget {
  final Map<String, dynamic> data;

  const PresetsWidget({super.key, required this.data});

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
    int originalColumnCount = widget.data["customizable_presets"]["pylons"].length - 1;
    int columnCount = originalColumnCount;
    if (originalColumnCount % 2 == 0) {
      columnCount += 1;
    }

    rows = {};
    for (int rowIndex = 0; rowIndex < widget.data["presets"].length; rowIndex++) {
      List<Widget> columns = List.generate(
        columnCount,
        (index) => Container(
          height: 40,
          width: 40,
          color: Colors.grey[300],
        ),
      );
      var preset = widget.data["presets"][rowIndex];
      if (preset["weapons"].isEmpty) {
        rows["row_$rowIndex"] = columns;
        continue;
      }
      for (int colIndex = 0; colIndex < originalColumnCount; colIndex++) {
        int adjustedColIndex = colIndex;
        if (originalColumnCount % 2 == 0 && colIndex >= originalColumnCount ~/ 2) {
          adjustedColIndex += 1;
        }
        var pylon = widget.data["customizable_presets"]["pylons"][colIndex + 1];
        for (var weapon in preset["weapons"]) {
          for (var selectableWeapon in pylon["selectable_weapons"]) {
            if (selectableWeapon["name"] == weapon["name"]) {
              columns[adjustedColIndex] = InkWell(
                onTap: () {
                  print("Weapon: ${weapon["name"]}");
                  //WEAPON POPUP WITH AMMOS
                },
                child: Container(
                  height: 40,
                  width: 40,
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      weapon["name"],
                    ),
                  ),
                ),
              );
            }
          }
        }
      }
      rows["row_$rowIndex"] = columns;
    }
  }

  @override
  Widget build(BuildContext context) {
    int originalColumnCount = widget.data["customizable_presets"]["pylons"].length - 1;
    int columnCount = originalColumnCount;
    if (originalColumnCount % 2 == 0) {
      columnCount += 1;
    }

    return ExpansionTile(
      title: const Text('Presets'),
      children: [
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
                      rowSizes: List.generate(widget.data["presets"].length, (index) => auto),
                      columnGap: 5,
                      rowGap: 5,
                      children: [
                        for (int rowIndex = 0; rowIndex < widget.data["presets"].length; rowIndex++)
                          for (int colIndex = 0; colIndex < columnCount; colIndex++)
                            rows["row_$rowIndex"]![colIndex]?.withGridPlacement(
                                  columnStart: colIndex,
                                  rowStart: rowIndex,
                                ) ??
                                Container().withGridPlacement(
                                  columnStart: colIndex,
                                  rowStart: rowIndex,
                                ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
