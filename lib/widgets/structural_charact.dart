import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/constants.dart';

import '../classes/vehicle.dart';
import '../utils.dart';

class StructuralCharacteristicsCard extends StatelessWidget {
  final Vehicle dbVehicle;

  const StructuralCharacteristicsCard({super.key, required this.dbVehicle});

  @override
  Widget build(BuildContext context) {
    if (!Constants.aviationVehicleTypes.contains(dbVehicle.vehicleType)) {
      return const SizedBox.shrink();
    }

    return Card(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              const Text("Structural characteristics"),
              Table(children: [
                TableRow(children: [const Text("Length: "), Text("${dbVehicle.aerodynamics!.length} m", textAlign: TextAlign.center)]),
                TableRow(children: [const Text("Wingspan: "), Text("${dbVehicle.aerodynamics!.wingspan} m", textAlign: TextAlign.center)]),
                TableRow(children: [const Text("Wing area: "), Text("${dbVehicle.aerodynamics!.wingArea} m²", textAlign: TextAlign.center)]),
                TableRow(children: [const Text("Empty weight: "), Text("${formatBigNumber(dbVehicle.aerodynamics!.emptyWeight)} kg", textAlign: TextAlign.center)]),
                TableRow(children: [const Text("Max. takeoff weight: "), Text("${formatBigNumber(dbVehicle.aerodynamics!.maxTakeoffWeight)} kg", textAlign: TextAlign.center)])
              ])
            ])));
  }
}
