import 'package:flutter/material.dart';

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
    return Table(
      children: [
        _buildTableRow(["AB", "RB", "SB"], isHeader: true),
        _buildTableRow([
          _formatBR(data["arcade_br"]),
          _formatGroundBR(data["realistic_br"], data["realistic_ground_br"]),
          _formatGroundBR(data["simulator_br"], data["simulator_ground_br"]),
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
