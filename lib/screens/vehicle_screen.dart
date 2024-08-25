import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_wt_wiki/AppLocalisations.dart';
import 'package:flutter_wt_wiki/constants.dart';
import 'package:flutter_wt_wiki/widgets/br_table.dart';
import 'package:flutter_wt_wiki/widgets/modifications_expansion.dart';
import 'package:flutter_wt_wiki/widgets/required_tile.dart';

import 'package:http/http.dart' as http;

class VehicleScreen extends StatefulWidget {
  final String vehicleIdentifier;

  const VehicleScreen({super.key, required this.vehicleIdentifier});

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  final List<bool> _isExpandedList = List.generate(6, (_) => false);
  late Map<String, dynamic> jsonData;
  Map<String, dynamic>? EN_LOCALES;

  Future<void> initConstants() async {}

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
    initConstants();
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
            onPressed: () {},
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
                  Image.network(
                    jsonData['images']['image'],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Image.asset(Constants.COUNTRY_TO_FLAG_MAP[jsonData['country'] ?? 'usa']!, width: 50),
                            Text(jsonData['country'] ?? 'Unknown'),
                          ],
                        ),
                        const Spacer(),
                        Text("Rank ${_intToRoman(jsonData["era"])} "),
                      ],
                    ),
                  ),
                  if (jsonData['required_vehicle'] != null) RequiredTile(requiredVehicle: jsonData['required_vehicle']),
                  BrTable(data: jsonData),
                  Row(
                    children: [
                      const Text("Type: "),
                      Text(jsonData['vehicle_type']!),
                    ],
                  ),
                  const Card(
                    child: Column(
                      children: [
                        Row(
                          children: [Text("Test"), Text("Test"), Text("Test"), Text("Test")],
                        )
                      ],
                    ),
                  )
                  //const ModificationsExpansion()
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
