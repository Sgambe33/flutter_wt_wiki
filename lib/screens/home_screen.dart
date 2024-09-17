import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/AppLocalisations.dart';
import 'package:flutter_wt_wiki/constants.dart';
import 'package:flutter_wt_wiki/screens/vehicle_screen.dart';
import 'package:flutter_wt_wiki/widgets/homedrawer.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final Map<String, List<String>> _typesByCat = {
    'Aviation': Constants.AVIATION_VEHICLE_TYPES,
    'Ground': Constants.GROUND_VEHICLE_TYPES,
    'Fleet': Constants.FLEET_VEHICLE_TYPES,
  };

  int _selectedCategory = 0;

  Future<List<dynamic>> _fetchData(String type) async {
    final response = await http.get(Uri.parse('https://wtvehiclesapi.sgambe.serv00.net/api/vehicles?type=$type'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load chart data');
    }
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
    String selectedType = _typesByCat.keys.elementAt(_selectedCategory);

    String filterType = _typesByCat[selectedType]!.asMap().values.join(',');
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
          future: _fetchData(filterType),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              double screenWidth = MediaQuery.of(context).size.width;
              int crossAxisCount = max((screenWidth / 200).floor(), 2);
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                  ),
                  shrinkWrap: true,
                  addAutomaticKeepAlives: true,
                  itemCount: snapshot.data!.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VehicleScreen(
                              vehicleIdentifier: item['identifier'],
                            ),
                          ),
                        );
                      },
                      child: GridTile(
                        header: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: Text(
                            item['identifier'] != null
                                ? AppLocalizations.of(context).stringBy('vehicles', (item['identifier'] + "_short").toLowerCase())
                                : item['identifier'],
                            textAlign: TextAlign.center,
                          ),
                        ),
                        footer: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                Constants.COUNTRY_TO_FLAG_MAP[item['country']]!,
                                width: 40,
                                height: 40,
                              ),
                              Text(
                                "Rank ${_intToRoman(item['era'])} ${Constants.VEHICLE_TYPE_TO_ICON[item['vehicle_type']] ?? ''}",
                                textAlign: TextAlign.right,
                                style: const TextStyle(fontFamily: 'CustomFont'),
                              ),
                            ],
                          ),
                        ),
                        child: Card(
                            child: CachedNetworkImage(
                                imageUrl: item['images']['image'],
                                imageBuilder: (context, imageProvider) => Image(
                                    image: imageProvider,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }),
                                errorWidget: (context, url, error) => Image.asset('assets/images/uknown.png'))),
                      ),
                    );
                  });
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Shuffle the loaded data
          setState(() {});
        },
        child: const Icon(Icons.shuffle),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedCategory,
        onTap: (int index) {
          setState(() {
            _selectedCategory = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.flight_takeoff),
            label: 'Aviation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Ground',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_ferry),
            label: 'Fleet',
          ),
        ],
      ),
    );
  }
}
