import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_wt_wiki/constants.dart';
import 'package:flutter_wt_wiki/widgets/modifications_expansion.dart';

class VehicleScreen extends StatefulWidget {
  //final String jsonData;

  const VehicleScreen({super.key});

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  final List<bool> _isExpandedList = List.generate(6, (_) => false);
  Map<String, dynamic>? vehicleData;
  Map<String, dynamic>? EN_LOCALES;

  Future<void> initConstants() async {}

  Future<void> loadJson() async {
    String response =
        await rootBundle.loadString('assets/fakevehicles/a6m2.json');
    vehicleData = await json.decode(response);
    response = await rootBundle.loadString('assets/en.json');
    EN_LOCALES = json.decode(response);
  }

  @override
  void initState() {
    super.initState();
    loadJson();
    initConstants();
  }

  @override
  Widget build(BuildContext context) {
    print(EN_LOCALES);
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                EN_LOCALES?['vehicles']
                        [vehicleData?['identifier'] + "_short"] ??
                    'Unknown',
                style: const TextStyle(fontFamily: 'CustomFont'),
              ),
              const Spacer(),
              DropdownButton(
                value: '2.37.0.126',
                items: const [
                  DropdownMenuItem(
                    value: '2.37.0.126',
                    enabled: true,
                    child: Text('2.37.0.126'),
                  )
                ],
                onChanged: (String? value) {},
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Image.network(
              "https://wtvehiclesapi.sgambe.serv00.net/assets/images/a6m2_zero_usa.png",
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: [
                  Row(
                    children: [
                      Image.asset(
                          Constants.COUNTRY_TO_FLAG_MAP[
                              vehicleData?['country'] ?? 'usa']!,
                          width: 50),
                      Text(vehicleData?['country'] ?? 'Unknown'),
                    ],
                  ),
                  const Spacer(),
                  Text("${vehicleData?["era"]} Rank"),
                ],
              ),
            ),
            Table(
              children: [
                const TableRow(
                  children: [
                    Text(
                      "AB",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "RB",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "SB",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      vehicleData?["arcade_br"].toString() ?? "1.0",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      vehicleData?["realistic_br"].toString() ?? "1.0",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      vehicleData?["simulator_br"].toString() ?? "1.0",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            ModificationsExpansion()
          ]),
        ));
  }
}
