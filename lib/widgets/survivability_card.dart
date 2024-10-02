import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/constants.dart';

import '../classes/vehicle.dart';

class SurvivabilityCard extends StatelessWidget {
  final Vehicle dbVehicle;

  const SurvivabilityCard({super.key, required this.dbVehicle});

  @override
  Widget build(BuildContext context) {
    if (!Constants.groundVehicleTypes.contains(dbVehicle.vehicleType)) {
      return const SizedBox.shrink();
    }
    return Card(
        child: Column(children: [
      const Text("Survivability"),
      const Text("Hull armor"),
      Table(children: [
        const TableRow(children: [Text("Hull front"), Text("Hull side"), Text("Hull back")]),
        TableRow(children: [Text("${dbVehicle.hullArmor[0]}mm"), Text("${dbVehicle.hullArmor[1]}mm"), Text("${dbVehicle.hullArmor[2]}mm")])
      ]),
      const Text("Turret armor"),
      Table(children: [
        const TableRow(children: [Text("Turret front"), Text("Turret side"), Text("Turret back")]),
        TableRow(children: [Text("${dbVehicle.turretArmor[0]}mm"), Text("${dbVehicle.turretArmor[1]}mm"), Text("${dbVehicle.turretArmor[2]}mm")])
      ])
    ]));
  }
}
