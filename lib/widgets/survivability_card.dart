import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/Constants.dart';

class SurvivabilityCard extends StatelessWidget {
  final Map<String, dynamic> jsonData;

  const SurvivabilityCard({super.key, required this.jsonData});

  @override
  Widget build(BuildContext context) {
    if (!Constants.GROUND_VEHICLE_TYPES.contains(jsonData["vehicle_type"])) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Column(
        children: [
          const Text("Survivability"),
          const Text("Hull armor"),
          Table(
            children: [
              const TableRow(
                children: [
                  Text("Hull front"),
                  Text("Hull side"),
                  Text("Hull back"),
                ],
              ),
              TableRow(
                children: [
                  Text("${jsonData['hull_armor'][0]}mm"),
                  Text("${jsonData['hull_armor'][1]}mm"),
                  Text("${jsonData['hull_armor'][2]}mm"),
                ],
              ),
            ],
          ),
          const Text("Turret armor"),
          Table(
            children: [
              const TableRow(
                children: [
                  Text("Turret front"),
                  Text("Turret side"),
                  Text("Turret back"),
                ],
              ),
              TableRow(
                children: [
                  Text("${jsonData['turret_armor'][0]}mm"),
                  Text("${jsonData['turret_armor'][1]}mm"),
                  Text("${jsonData['turret_armor'][2]}mm"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
