import 'package:flutter/material.dart';

import '../classes/vehicle.dart';

class PriceCard extends StatelessWidget {
  final Vehicle dbVehicle;

  const PriceCard({super.key, required this.dbVehicle});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(children: [
      if (dbVehicle.isPremium && dbVehicle.isPack)
        const Text("Bundle or gift")
      else if (dbVehicle.isPremium)
        Table(children: [
          const TableRow(children: [Text("Purchase: ", textAlign: TextAlign.center)]),
          TableRow(children: [Text("${dbVehicle.geCost} ¤", textAlign: TextAlign.center)])
        ])
      else if (dbVehicle.onMarketplace)
        const Text("Can be found on the marketplace ⋬")
      else if (dbVehicle.squadronVehicle) ...[
        Table(children: [
          const TableRow(children: [Text("Research: ", textAlign: TextAlign.center)]),
          TableRow(children: [Text("${dbVehicle.reqExp} SP", textAlign: TextAlign.center)])
        ])
      ]
    ]));
  }
}
