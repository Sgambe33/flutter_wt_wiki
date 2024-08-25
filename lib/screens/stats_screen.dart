import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/constants.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsScreen extends StatefulWidget {
  StatsScreen({super.key});

  final Color leftBarColor = Colors.blue;
  final Color rightBarColor = Colors.red;
  final Color avgColor = Colors.green;

  @override
  State<StatefulWidget> createState() => StatsScreenState();
}

class StatsScreenState extends State<StatsScreen> {
  late List<ChartData> data;
  late List<dynamic> vehicleTypes;
  late TooltipBehavior _tooltip;
  String selectedValue = '═SL';
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _tooltip = TooltipBehavior(
        enable: true, textStyle: const TextStyle(fontFamily: 'CustomFont'));
    data = [];
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://wtvehiclesapi.sgambe.serv00.net/api/vehicles/stats'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['countries'];
      setState(() {
        data = jsonData.map((item) => ChartData.fromJson(item)).toList();
        vehicleTypes = jsonData.map((item) => item['vehicle_types']).toList();
      });
    } else {
      throw Exception('Failed to load chart data');
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxY = data.isNotEmpty
        ? data
            .map((d) {
              switch (selectedValue) {
                case '═SL':
                  return d.SL;
                case '▉RP':
                  return d.RP;
                case '¤GE':
                  return d.GE;
                default:
                  return 0;
              }
            })
            .reduce((a, b) => a > b ? a : b)
            .toDouble()
        : 40.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        actions: [
          DropdownButton<String>(
            value: selectedValue,
            items: const [
              DropdownMenuItem(value: '═SL', child: Text('Silver Lions')),
              DropdownMenuItem(value: '▉RP', child: Text('Research Points')),
              DropdownMenuItem(value: '¤GE', child: Text('Golden Eagles')),
            ],
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue!;
              });
            },
          ),
        ],
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: _handlePageViewChanged,
        physics: const BouncingScrollPhysics(),
        children: [
          buildEconomyChart(),
          for (int i = 0; i < data.length; i++)
            buildVehiclesChart(vehicleTypes[i])
        ],
      ),
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    setState(() {
      _currentPageIndex = currentPageIndex;
      _updateCurrentPageIndex(_currentPageIndex);
    });
  }

  void _updateCurrentPageIndex(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Widget buildVehiclesChart(Map<String, dynamic> vehicleTypes) {
    return data.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : const SfCircularChart();
  }

  Widget buildEconomyChart() {
    return data.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
            primaryYAxis: const NumericAxis(),
            tooltipBehavior: _tooltip,
            title: const ChartTitle(text: 'Economy'),
            series: <CartesianSeries<ChartData, String>>[
              BarSeries<ChartData, String>(
                dataSource: data,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) {
                  switch (selectedValue) {
                    case '═SL':
                      return data.SL;
                    case '▉RP':
                      return data.RP;
                    case '¤GE':
                      return data.GE;
                    default:
                      return 0;
                  }
                },
                name: selectedValue,
                color: selectedValue == '═SL'
                    ? Colors.grey
                    : selectedValue == '▉RP'
                        ? Colors.blueAccent
                        : Colors.amber,
              ),
            ],
          );
  }
}

class ChartData {
  ChartData(this.x, this.SL, this.RP, this.GE);

  final String x;
  final int SL;
  final int RP;
  final int GE;

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      Constants.COUNTRY_TO_SHORT_MAP[json['country']] ?? 'Unknown',
      json['total_value'] ?? 0,
      json['total_req_exp'] ?? 0,
      json['total_ge_cost'] ?? 0,
    );
  }
}

class PieChartData {
  PieChartData(this.x, this.y, this.color);

  final String x;
  final int y;
  final Color color;

  factory PieChartData.fromJson(Map<String, dynamic> json, String key) {
    return PieChartData(
      Constants.COUNTRY_TO_SHORT_MAP[json['country']] ?? 'Unknown',
      json[key] ?? 0,
      Colors.primaries[json.length % Colors.primaries.length],
    );
  }
}
