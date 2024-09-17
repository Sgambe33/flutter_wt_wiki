import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/AppLocalisations.dart';
import 'package:flutter_wt_wiki/constants.dart';
import 'package:flutter_wt_wiki/widgets/br_table.dart';
import 'package:flutter_wt_wiki/widgets/combat_aid_expansion.dart';
import 'package:flutter_wt_wiki/widgets/economy_table.dart';
import 'package:flutter_wt_wiki/widgets/preset_widget.dart';
import 'package:flutter_wt_wiki/widgets/price_card.dart';
import 'package:flutter_wt_wiki/widgets/required_tile.dart';
import 'package:flutter_wt_wiki/widgets/simple_presets_widget.dart';
import 'package:flutter_wt_wiki/widgets/structural_charact.dart';
import 'package:flutter_wt_wiki/widgets/survivability_card.dart';
import 'package:flutter_wt_wiki/widgets/vehicle_version_dialog.dart';

import 'package:http/http.dart' as http;

class VehicleScreen extends StatefulWidget {
  final String vehicleIdentifier;

  const VehicleScreen({super.key, required this.vehicleIdentifier});

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  late Map<String, dynamic> jsonData;

  Future<Map<String, dynamic>> loadJson() async {
    final response = await http.get(Uri.parse('https://wtvehiclesapi.sgambe.serv00.net/api/vehicles/${widget.vehicleIdentifier}'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load chart data');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  String _intToRoman(int num) {
    switch (num) {
      case 1:
        return 'I';
      case 2:
        return 'II';
      case 3:
        return 'III';
      case 4:
        return 'IV';
      case 5:
        return 'V';
      case 6:
        return 'VI';
      case 7:
        return 'VII';
      case 8:
        return 'VIII';
      case 9:
        return 'IX';
      case 10:
        return 'X';
      default:
        return num.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).stringBy('vehicles', ("${widget.vehicleIdentifier}_short").toLowerCase()),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              VehicleVersionDialog.show(context, jsonData['versions']);
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: loadJson(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            jsonData = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 4.0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    margin: const EdgeInsets.all(4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text("${Constants.TYPE_TO_TYPE_NAME[jsonData['vehicle_type']] ?? ""} ${Constants.VEHICLE_TYPE_TO_ICON[jsonData['vehicle_type']!]}"),
                          CachedNetworkImage(
                            imageUrl: jsonData['images']['image'],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(Constants.COUNTRY_TO_FLAG_MAP[jsonData['country'] ?? 'usa']!, width: 50),
                                    const SizedBox(width: 10),
                                    Text(Constants.COUNTRY_TO_COUNTRY_NAME[jsonData['country']] ?? 'Unknown'),
                                  ],
                                ),
                                const Spacer(),
                                Text("Rank ${_intToRoman(jsonData["era"])} "),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (jsonData['required_vehicle'] != null) RequiredTile(requiredVehicle: jsonData['required_vehicle']),
                  BrTable(data: jsonData),
                  PriceCard(jsonData: jsonData),
                  EconomyTable(data: jsonData),
                  //ModificationsExpansion(data: jsonData), WIP
                  SurvivabilityCard(jsonData: jsonData),
                  StructuralCharacteristicsCard(jsonData: jsonData),
                  CombatAidExpansion(data: jsonData),
                  const Card(
                    child: Column(children: [Text("Weapons")]),
                  ),
                  if (jsonData['has_customizable_weapons']) PresetsWidget(data: jsonData),
                  if (!jsonData['presets'].isEmpty && !jsonData['has_customizable_weapons']) SimplePresetsWidget(presets: jsonData['presets']),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
