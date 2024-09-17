import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatsScreen extends StatefulWidget {
  StatsScreen({super.key});

  final Color leftBarColor = Colors.blue;
  final Color rightBarColor = Colors.red;
  final Color avgColor = Colors.green;

  @override
  State<StatefulWidget> createState() => StatsScreenState();
}

class StatsScreenState extends State<StatsScreen> {
  late List<dynamic> countriesData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://wtvehiclesapi.sgambe.serv00.net/api/vehicles/stats'));
    if (response.statusCode == 200) {
      setState(() {
        countriesData = json.decode(response.body)['countries'];
      });
    } else {
      throw Exception('Failed to load chart data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Stats'),
        ),
        body: countriesData.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: countriesData.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Text(countriesData[index]['country'].toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Table(
                          children: [
                            TableRow(children: [
                              const TableCell(child: Text('Total SL:')),
                              TableCell(child: Text(countriesData[index]['total_value'].toString())),
                            ]),
                            TableRow(children: [
                              const TableCell(child: Text('Total RP:')),
                              TableCell(child: Text(countriesData[index]['total_req_exp'].toString())),
                            ]),
                            TableRow(children: [
                              const TableCell(child: Text('Total GE:')),
                              TableCell(child: Text(countriesData[index]['total_ge_cost'].toString())),
                            ]),
                            TableRow(children: [
                              const TableCell(child: Text('Total SL:')),
                              TableCell(child: Text(countriesData[index]['total_value'].toString())),
                            ]),
                            TableRow(children: [
                              const TableCell(child: Text('Total vehicles:')),
                              TableCell(child: Text(countriesData[index]['total_vehicles'].toString())),
                            ]),
                          ],
                        ),
                        //ExpansionTile(title: Text('Vehicles'), children: [
                        //  ListView.builder(
                        //    shrinkWrap: true,
                        //    itemCount: countriesData[index]['vehicle_types'].length,
                        //    itemBuilder: (context, i) {
                        //      String vehicleType = countriesData[index]['vehicle_types'].keys.elementAt(i);
                        //      int vehicleCount = countriesData[index]['vehicle_types'][vehicleType];
                        //
                        //      return Text('${Constants.VEHICLE_TYPE_TO_ICON[vehicleType]}${Constants.TYPE_TO_TYPE_NAME[vehicleType]}: $vehicleCount');
                        //    },
                        //  )
                        //]),
                      ],
                    ),
                  );
                }));
  }
}
