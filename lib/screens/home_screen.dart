import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/AppLocalisations.dart';
import 'package:flutter_wt_wiki/constants.dart';
import 'package:flutter_wt_wiki/screens/vehicle_screen.dart';
import 'package:flutter_wt_wiki/widgets/homedrawer.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double paddingValue = 8.0;
  static const Duration animationDuration = Duration(milliseconds: 300);

  final List<Map<String, dynamic>> _filters = [
    {
      'name': 'Britain',
      'selected': true,
      'image': 'assets/images/country_britain_big.png',
      'image_deactivated': 'assets/images/country_britain_big_locked.png'
    },
    {'name': 'China', 'selected': true, 'image': 'assets/images/country_china_big.png', 'image_deactivated': 'assets/images/country_china_big_locked.png'},
    {'name': 'France', 'selected': true, 'image': 'assets/images/country_france_big.png', 'image_deactivated': 'assets/images/country_france_big_locked.png'},
    {
      'name': 'Germany',
      'selected': true,
      'image': 'assets/images/country_germany_big.png',
      'image_deactivated': 'assets/images/country_germany_big_locked.png'
    },
    {'name': 'Israel', 'selected': true, 'image': 'assets/images/country_israel_big.png', 'image_deactivated': 'assets/images/country_israel_big_locked.png'},
    {
      'name': 'Italy',
      'selected': true,
      'image': 'assets/images/country_italy_kingdom_big.png',
      'image_deactivated': 'assets/images/country_italy_kingdom_big_locked.png'
    },
    {'name': 'Japan', 'selected': true, 'image': 'assets/images/country_japan_big.png', 'image_deactivated': 'assets/images/country_japan_big_locked.png'},
    {'name': 'Sweden', 'selected': true, 'image': 'assets/images/country_sweden_big.png', 'image_deactivated': 'assets/images/country_sweden_big_locked.png'},
    {'name': 'USA', 'selected': true, 'image': 'assets/images/country_usa_big.png', 'image_deactivated': 'assets/images/country_usa_big_locked.png'},
    {'name': 'USSR', 'selected': true, 'image': 'assets/images/country_ussr_big.png', 'image_deactivated': 'assets/images/country_ussr_big_locked.png'},
  ];

  final Map<String, List<String>> _typesByCat = {
    'Aviation': ['assault', 'attack_helicopter', 'fighter', 'bomber', 'utility_helicopter'],
    'Ground': ['heavy_tank', 'light_tank', 'medium_tank', 'spaa', 'tank_destroyer'],
    'Fleet': ['boat', 'destroyer', 'battleship', 'battlecruiser', 'frigate', 'heavy_cruiser', 'heavy_boat', 'light_cruiser', 'barge']
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

  void _toggleFilterSelection(Map<String, dynamic> filter) {
    setState(() {
      filter['selected'] = !filter['selected'];
    });
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

  Widget _buildFilterRow(List<Map<String, dynamic>> filters) {
    return Row(
      children: filters.map((filter) {
        return Expanded(
          child: GestureDetector(
            onTap: () => _toggleFilterSelection(filter),
            child: Container(
              padding: const EdgeInsets.all(paddingValue),
              child: AnimatedSwitcher(
                duration: animationDuration,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Image.asset(
                  filter['selected'] ? filter['image'] : filter['image_deactivated'],
                  key: ValueKey<bool>(filter['selected']),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
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
          IconButton(
            icon: const Icon(Icons.filter_list_sharp),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (context, StateSetter setState) {
                      return AlertDialog(
                        title: const Text('Filter'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildFilterRow(_filters.sublist(0, 5)),
                              _buildFilterRow(_filters.sublist(5, 10)),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
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
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Adjust as needed
                  ),
                  shrinkWrap: true,
                  addAutomaticKeepAlives: true,
                  itemCount: snapshot.data!.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        // Define your onTap action here
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
                          padding: const EdgeInsets.fromLTRB(0, paddingValue, 0, 0),
                          child: Text(
                            item['identifier'] != null
                                ? AppLocalizations.of(context).stringBy('vehicles', (item['identifier'] + "_short").toLowerCase())
                                : item['identifier'],
                            textAlign: TextAlign.center,
                          ),
                        ),
                        footer: Padding(
                          padding: const EdgeInsets.all(paddingValue),
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
                          child: item['images']['image'] != null
                              ? Image.network(
                                  item['images']['image'],
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                )
                              : Image.asset('assets/images/uknown.png'), // Load asset image if URL is null,
                        ),
                      ),
                    );
                  });
            }
          }),
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
