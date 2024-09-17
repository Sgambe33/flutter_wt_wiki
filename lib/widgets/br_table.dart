import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/constants.dart';

class BrTable extends StatelessWidget {
  final Map<String, dynamic> data;
  const BrTable({super.key, required this.data});

  String _formatBR(dynamic value) {
    if (value is int) {
      return "${value}.0";
    }
    return value.toString();
  }

  String _formatGroundBR(dynamic orginalBr, dynamic groundBr) {
    if (orginalBr == groundBr) {
      return _formatBR(orginalBr);
    }
    return "${_formatBR(orginalBr)} (${_formatBR(groundBr)}▮)";
  }

  @override
  Widget build(BuildContext context) {
    bool isFleetType = Constants.FLEET_VEHICLE_TYPES.contains(data['vehicle_type']);
    return Table(
      children: [
        if (!isFleetType) _buildTableRow(["AB", "RB", "SB"], isHeader: true) else _buildTableRow(["AB", "RB"], isHeader: true),
        _buildTableRow([
          _formatBR(data["arcade_br"]),
          _formatGroundBR(data["realistic_br"], data["realistic_ground_br"]),
          if (!isFleetType) _formatBR(data["simulator_br"]),
        ]),
      ],
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      children: cells.map((cell) => _buildTableCell(cell, isHeader)).toList(),
    );
  }

  Widget _buildTableCell(String text, bool isHeader) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: isHeader ? const TextStyle(fontWeight: FontWeight.bold) : null,
      ),
    );
  }
}
