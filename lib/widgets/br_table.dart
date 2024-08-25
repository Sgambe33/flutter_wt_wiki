import 'package:flutter/material.dart';

class BrTable extends StatelessWidget {
  final Map<String, dynamic> data;
  const BrTable({super.key, required this.data});

  //? TODO: Remove ground BR from tanks and ships
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        _buildTableRow(["AB", "RB", "SB"], isHeader: true),
        _buildTableRow([
          data["arcade_br"].toString(),
          "${data["realistic_br"].toString()} (${data["realistic_ground_br"]}▮)",
          "${data["simulator_br"].toString()} (${data["simulator_ground_br"]}▮)",
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
