import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/constants.dart';

import '../classes/vehicle.dart';

class BrTable extends StatelessWidget {
  final Vehicle dbVehicle;

  const BrTable({super.key, required this.dbVehicle});

  String _formatBR(dynamic value) {
    if (value is int) return "$value.0";
    return value.toString();
  }

  String _formatGroundBR(dynamic orginalBr, dynamic groundBr) {
    if (orginalBr == groundBr) return _formatBR(orginalBr);
    return "${_formatBR(orginalBr)} (${_formatBR(groundBr)}▮)";
  }

  @override
  Widget build(BuildContext context) {
    bool isFleetType = Constants.fleetVehicleTypes.contains(dbVehicle.vehicleType);
    return Table(children: [
      if (!isFleetType) _buildTableRow(["AB", "RB", "SB"], isHeader: true) else _buildTableRow(["AB", "RB"], isHeader: true),
      _buildTableRow([_formatBR(dbVehicle.arcadeBr), _formatGroundBR(dbVehicle.realisticBr, dbVehicle.realisticGroundBr), if (!isFleetType) _formatBR(dbVehicle.simulatorBr)])
    ]);
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(children: cells.map((cell) => _buildTableCell(cell, isHeader)).toList());
  }

  Widget _buildTableCell(String text, bool isHeader) {
    return Padding(padding: const EdgeInsets.all(8.0), child: Text(text, textAlign: TextAlign.center, style: isHeader ? const TextStyle(fontWeight: FontWeight.bold) : null));
  }
}
