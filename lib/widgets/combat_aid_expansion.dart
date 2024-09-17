import 'package:flutter/material.dart';

class CombatAidExpansion extends StatefulWidget {
  final Map<String, dynamic> data;
  const CombatAidExpansion({super.key, required this.data});

  @override
  _CombatAidExpansionState createState() => _CombatAidExpansionState();
}

class _CombatAidExpansionState extends State<CombatAidExpansion> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ExpansionTile(title: const Text('Combat Aid'), children: <Widget>[
      const Text("IR & thermal devices"),
      Table(
        children: [
          const TableRow(
            children: [
              Text(''),
              Text("IR"),
              Text("Thermal"),
            ],
          ),
          TableRow(
            children: [
              const Text('Commander'),
              Text(widget.data["ir_devices"]["commander_device"].toString()),
              Text(widget.data["thermal_devices"]["commander_device"].toString()),
            ],
          ),
          TableRow(
            children: [
              const Text('Driver'),
              Text(widget.data["ir_devices"]["driver_device"].toString()),
              Text(widget.data["thermal_devices"]["driver_device"].toString()),
            ],
          ),
          TableRow(
            children: [
              const Text('Gunner'),
              Text(widget.data["ir_devices"]["gunner_device"].toString()),
              Text(widget.data["thermal_devices"]["gunner_device"].toString()),
            ],
          ),
          TableRow(
            children: [
              const Text('Sight'),
              Text(widget.data["ir_devices"]["sight_device"].toString()),
              Text(widget.data["thermal_devices"]["sight_device"].toString()),
            ],
          ),
          TableRow(
            children: [
              const Text('Pilot'),
              Text(widget.data["ir_devices"]["pilot_device"].toString()),
              Text(widget.data["thermal_devices"]["pilot_device"].toString()),
            ],
          ),
          TableRow(
            children: [
              const Text('Pod'),
              Text(widget.data["ir_devices"]["targeting_pod_device"].toString()),
              Text(widget.data["thermal_devices"]["targeting_pod_device"].toString()),
            ],
          ),
        ],
      )
    ]));
  }
}
