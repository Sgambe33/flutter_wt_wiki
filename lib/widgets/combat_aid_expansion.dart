import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/classes/vehicle.dart';

class CombatAidExpansion extends StatefulWidget {
  final Vehicle dbVehicle;

  const CombatAidExpansion({super.key, required this.dbVehicle});

  @override
  _CombatAidExpansionState createState() => _CombatAidExpansionState();
}

class _CombatAidExpansionState extends State<CombatAidExpansion> {
  TableRow _buildTableRow(String label, String? irValue, String? thermalValue) {
    if (irValue == null && thermalValue == null) return const TableRow(children: [SizedBox.shrink(), SizedBox.shrink(), SizedBox.shrink()]);
    return TableRow(children: [Text(label), Text(irValue ?? "No", textAlign: TextAlign.center), Text(thermalValue ?? "No", textAlign: TextAlign.center)]);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ExpansionTile(title: const Text('Combat Aid'), children: <Widget>[
      const Text("IR & thermal devices"),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(children: [
            const TableRow(children: [SizedBox.shrink(), Text("IR", textAlign: TextAlign.center), Text("Thermal", textAlign: TextAlign.center)]),
            _buildTableRow('Commander:', widget.dbVehicle.irDevices!.commanderDevice, widget.dbVehicle.thermalDevices!.commanderDevice),
            _buildTableRow('Driver:', widget.dbVehicle.irDevices!.driverDevice, widget.dbVehicle.thermalDevices!.driverDevice),
            _buildTableRow('Gunner:', widget.dbVehicle.irDevices!.gunnerDevice, widget.dbVehicle.thermalDevices!.gunnerDevice),
            _buildTableRow('Sight:', widget.dbVehicle.irDevices!.sightDevice, widget.dbVehicle.thermalDevices!.sightDevice),
            _buildTableRow('Pilot:', widget.dbVehicle.irDevices!.pilotDevice, widget.dbVehicle.thermalDevices!.pilotDevice),
            _buildTableRow('Pod:', widget.dbVehicle.irDevices!.targetingPodDevice, widget.dbVehicle.thermalDevices!.targetingPodDevice)
          ]))
    ]));
  }
}
