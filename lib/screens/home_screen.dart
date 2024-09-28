import 'dart:developer' as dev;
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/AppLocalisations.dart';
import 'package:flutter_wt_wiki/classes/synthetic_vehicle.dart';
import 'package:flutter_wt_wiki/constants.dart';
import 'package:flutter_wt_wiki/database_helper.dart';
import 'package:flutter_wt_wiki/screens/vehicle_screen.dart';
import 'package:flutter_wt_wiki/widgets/homedrawer.dart';

import '../classes/vehicle.dart';
import '../utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final Map<String, List<String>> _typesByCat = {
    'Aviation': Constants.aviationVehicleTypes,
    'Ground': Constants.groundVehicleTypes,
    'Fleet': Constants.fleetVehicleTypes,
  };

  int _selectedCategory = 0;

  Future<List<dynamic>> _fetchData(List<String> type) async {
    List<String> whereClauses = [];
    List<dynamic> whereArgs = [];

    if (type.isNotEmpty) {
      whereClauses.add("vehicle_type IN (${List.filled(type.length, "?").join(',')})");
      type.forEach((element) {
        whereArgs.add(element);
      });
    }

    String whereClause = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : "";

    try {
      List<SyntheticVehicle> dbVehicles = await DatabaseHelper().getSyntheticVehiclesByFilters("vehicle", whereClause, whereArgs);
      if (dbVehicles.isEmpty) {
        dev.log("No vehicles found in the database for the given query: $whereClause with args: $whereArgs");
        return [];
      }
      return dbVehicles;
    } catch (e) {
      dev.log("Error querying the database: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    String selectedType = _typesByCat.keys.elementAt(_selectedCategory);
    List<String>? filterTypes = _typesByCat[selectedType];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => Navigator.of(context).pushNamed('/search'),
            ),
            IconButton(icon: const Icon(Icons.filter_list_sharp), onPressed: () async {})
          ],
        ),
        drawer: const HomeDrawer(),
        body: FutureBuilder<List<dynamic>>(
            future: _fetchData(filterTypes!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                double screenWidth = MediaQuery.of(context).size.width;
                int crossAxisCount = max((screenWidth / 200).floor(), 2);
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount),
                    shrinkWrap: true,
                    addAutomaticKeepAlives: true,
                    itemCount: snapshot.data!.length ?? 0,
                    itemBuilder: (context, index) {
                      final SyntheticVehicle dbVehicle = snapshot.data![index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => VehicleScreen(vehicleIdentifier: dbVehicle.identifier!)),
                            );
                          },
                          child: GridTile(
                              header: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: Text(dbVehicle.identifier != null ? AppLocalizations.of(context).stringBy('vehicles', ("${dbVehicle.identifier!}_short").toLowerCase()) : dbVehicle.identifier!,
                                    textAlign: TextAlign.center),
                              ),
                              footer: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(Constants.countryToFlagMap[dbVehicle.country]!, width: 40, height: 40),
                                    Text("Rank ${intToRoman(dbVehicle.era)} ${Constants.vehicleTypeToIcon[dbVehicle.vehicleType] ?? ''}",
                                        textAlign: TextAlign.right, style: const TextStyle(fontFamily: 'CustomFont')),
                                  ],
                                ),
                              ),
                              child: Card(
                                  child: CachedNetworkImage(
                                      imageUrl: "https://wtvehiclesapi.sgambe.serv00.net/assets/images/${dbVehicle.identifier!.toLowerCase()}.png",
                                      imageBuilder: (context, imageProvider) => Image(
                                          image: imageProvider,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return const Center(child: CircularProgressIndicator());
                                            }
                                          }),
                                      errorWidget: (context, url, error) => Image.asset('assets/images/uknown.png')))));
                    });
              }
            }),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              //TODO: Implement shuffle
            },
            child: const Icon(Icons.shuffle)),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedCategory,
          onTap: (int index) {
            setState(() {
              _selectedCategory = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.flight_takeoff), label: 'Aviation'),
            BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Ground'),
            BottomNavigationBarItem(icon: Icon(Icons.directions_ferry), label: 'Fleet')
          ],
        ));
  }
}
