import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/Constants.dart';

class StructuralCharacteristicsCard extends StatelessWidget {
  final Map<String, dynamic> jsonData;

  const StructuralCharacteristicsCard({super.key, required this.jsonData});

  @override
  Widget build(BuildContext context) {
    if (!Constants.AVIATION_VEHICLE_TYPES.contains(jsonData["vehicle_type"])) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Column(
        children: [
          const Text("Structural characteristics"),
          Table(
            children: [
              TableRow(children: [
                const Text("Length: "),
                Text("${jsonData['aerodynamics']['length']} m"),
              ]),
              TableRow(children: [
                const Text("Wingspan: "),
                Text("${jsonData['aerodynamics']['wingspan']} m"),
              ]),
              TableRow(children: [
                const Text("Wing area: "),
                Text("${jsonData['aerodynamics']['wing_area']} m²"),
              ]),
              TableRow(children: [
                const Text("Empty weight: "),
                Text("${jsonData['aerodynamics']['empty_weight']} kg"),
              ]),
              TableRow(children: [
                const Text("Max. takeoff weight: "),
                Text("${jsonData['aerodynamics']['max_takeoff_weight']} kg"),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
