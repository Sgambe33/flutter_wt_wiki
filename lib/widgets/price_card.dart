import 'package:flutter/material.dart';

class PriceCard extends StatelessWidget {
  final Map<String, dynamic> jsonData;

  const PriceCard({super.key, required this.jsonData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          if (jsonData['is_premium'] == true && jsonData['is_pack'] == true)
            const Text("Bundle or gift")
          else if (jsonData['is_premium'] == true)
            Table(
              children: [
                const TableRow(
                  children: [
                    Text("Purchase: ", textAlign: TextAlign.center),
                  ],
                ),
                TableRow(
                  children: [Text("${jsonData['ge_cost']} ¤", textAlign: TextAlign.center)],
                ),
              ],
            )
          else if (jsonData['on_marketplace'] == true)
            const Text("Can be found on the marketplace ⋬")
          else if (jsonData['squadron_vehicle'] == true) ...[
            Table(
              children: [
                const TableRow(
                  children: [
                    Text("Research: ", textAlign: TextAlign.center),
                  ],
                ),
                TableRow(
                  children: [Text("${jsonData['squadron_points']} SP", textAlign: TextAlign.center)],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}