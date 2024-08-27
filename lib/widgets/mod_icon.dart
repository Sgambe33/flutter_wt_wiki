import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/AppLocalisations.dart';

class ModIcon extends StatelessWidget {
  final Map<String, dynamic> modificationData;
  final double size;

  const ModIcon({super.key, this.size = 24, required this.modificationData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  Image.asset("assets/${modificationData['icon']}", width: size, height: size),
                  SizedBox(width: 10),
                  Text(AppLocalizations.of(context).stringBy('modifications', modificationData['name'])),
                ],
              ),
              content: Table(
                children: [
                  TableRow(
                    children: [
                      const Text("Repair coeff:"),
                      Text("+${modificationData['repair_coeff']}"),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("Purchase:"),
                      Text(modificationData['value'].toString()),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("Research:"),
                      Text(modificationData['req_exp'].toString()),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("GE cost:"),
                      Text(modificationData['ge_cost'].toString()),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("Required mod:"),
                      Text(modificationData['required_modification'].toString()),
                    ],
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
      child: Image.asset("assets/${modificationData['icon']}", width: size, height: size),
    );
  }
}
