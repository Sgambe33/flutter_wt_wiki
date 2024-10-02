import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/app_localizations.dart';
import 'package:flutter_wt_wiki/classes/vehicle.dart';
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

import '../database_helper.dart';
import '../utils.dart';

class VehicleScreen extends StatefulWidget {
  final String vehicleIdentifier;

  const VehicleScreen({super.key, required this.vehicleIdentifier});

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  Future<Vehicle> loadVehicleFromDb() async {
    Vehicle? dbVehicle = await DatabaseHelper().getVehicleById("vehicle", widget.vehicleIdentifier);
    if (dbVehicle == null) {
      log("No vehicle found in the database for the given query: ${widget.vehicleIdentifier}");
      return Vehicle();
    }
    return dbVehicle;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context).stringBy('vehicles', ("${widget.vehicleIdentifier}_short").toLowerCase())), actions: [
          IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                //VehicleVersionDialog.show(context, jsonData['versions']);
              })
        ]),
        body: FutureBuilder<Vehicle>(
            future: loadVehicleFromDb(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                Vehicle dbVehicle = snapshot.data!;
                return SingleChildScrollView(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Card(
                      elevation: 4.0,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
                      margin: const EdgeInsets.all(4.0),
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(children: [
                            Text("${Constants.typeToTypeName[dbVehicle.vehicleType] ?? ""} ${Constants.vehicleTypeToIcon[dbVehicle.vehicleType]}"),
                            CachedNetworkImage(
                                imageUrl: "https://wtvehiclesapi.sgambe.serv00.net/assets/images/${dbVehicle.identifier!.toLowerCase()}.png",
                                errorWidget: (context, url, error) => Image.asset('assets/images/uknown.png')),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(children: [
                                  Row(children: [
                                    Image.asset(Constants.countryToFlagMap[dbVehicle.country ?? 'usa']!, width: 50),
                                    const SizedBox(width: 10),
                                    Text(Constants.countryToCountryName[dbVehicle.country] ?? 'Unknown')
                                  ]),
                                  const Spacer(),
                                  Text("Rank ${intToRoman(dbVehicle.era)}")
                                ]))
                          ]))),
                  if (dbVehicle.requiredVehicle != null) RequiredTile(requiredVehicle: dbVehicle.requiredVehicle!),
                  BrTable(dbVehicle: dbVehicle),
                  PriceCard(dbVehicle: dbVehicle),
                  EconomyTable(dbVehicle: dbVehicle),
                  //ModificationsExpansion(data: jsonData), WIP
                  SurvivabilityCard(dbVehicle: dbVehicle),
                  StructuralCharacteristicsCard(dbVehicle: dbVehicle),
                  CombatAidExpansion(dbVehicle: dbVehicle),
                  const Card(child: Column(children: [Text("Weapons")])),
                  if (dbVehicle.hasCustomizableWeapons) PresetsWidget(dbVehicle: dbVehicle),
                  if (dbVehicle.presets.isNotEmpty && !dbVehicle.hasCustomizableWeapons) SimplePresetsWidget(presets: dbVehicle.presets),
                ]));
              } else {
                return const Center(child: Text('No data available'));
              }
            }));
  }
}
