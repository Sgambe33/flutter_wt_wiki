import 'package:flutter/material.dart';

class EconomyTable extends StatefulWidget {
  final Map<String, dynamic> data;
  const EconomyTable({Key? key, required this.data}) : super(key: key);

  @override
  _EconomyTableState createState() => _EconomyTableState();
}

class _EconomyTableState extends State<EconomyTable> {
  String _selectedChip = "AB";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ChoiceChip(
                label: const Text("AB"),
                selected: _selectedChip == "AB",
                elevation: 4,
                onSelected: (bool selected) {
                  setState(() {
                    _selectedChip = "AB";
                  });
                },
              ),
              ChoiceChip(
                label: const Text("RB"),
                selected: _selectedChip == "RB",
                onSelected: (bool selected) {
                  setState(() {
                    _selectedChip = "RB";
                  });
                },
              ),
              ChoiceChip(
                label: const Text("SB"),
                selected: _selectedChip == "SB",
                onSelected: (bool selected) {
                  setState(() {
                    _selectedChip = "SB";
                  });
                },
              ),
            ],
          ),
          Table(
            children: [
              TableRow(
                children: [
                  const Text("SL bonus"),
                  Text(
                    _selectedChip == "AB"
                        ? "${(widget.data['sl_mul_arcade'] * 100).round()}%"
                        : _selectedChip == "RB"
                            ? "${(widget.data['sl_mul_realistic'] * 100).round()}%"
                            : "${(widget.data['sl_mul_simulator'] * 100).round()}%",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Text("RP bonus"),
                  Text(
                    "${(widget.data['exp_mul'] * 100).round()}%",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Text("Repair cost"),
                  Text(
                    _selectedChip == "AB"
                        ? "${widget.data['repair_cost_arcade']}€"
                        : _selectedChip == "RB"
                            ? "${widget.data['repair_cost_realistic']}€"
                            : "${widget.data['repair_cost_simulator']}€",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Text("Repair cost /min"),
                  Text(
                    _selectedChip == "AB"
                        ? "${widget.data['repair_cost_per_min_arcade']}€"
                        : _selectedChip == "RB"
                            ? "${widget.data['repair_cost_per_min_realistic']}€"
                            : "${widget.data['repair_cost_per_min_simulator']}€",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Text("Repair cost (spaded)"),
                  Text(
                    _selectedChip == "AB"
                        ? "${widget.data['repair_cost_full_upgraded_arcade']}€"
                        : _selectedChip == "RB"
                            ? "${widget.data['repair_cost_full_upgraded_realistic']}€"
                            : "${widget.data['repair_cost_full_upgraded_simulator']}€",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Text("Repair time"),
                  Text(
                    _selectedChip == "AB"
                        ? formatDuration(widget.data['repair_time_arcade'])
                        : _selectedChip == "RB"
                            ? formatDuration(widget.data['repair_time_realistic'])
                            : formatDuration(widget.data['repair_time_simulator']),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Text("Repair time (no crew)"),
                  Text(
                    _selectedChip == "AB"
                        ? formatDuration(widget.data['repair_time_no_crew_arcade'])
                        : _selectedChip == "RB"
                            ? formatDuration(widget.data['repair_time_no_crew_realistic'])
                            : formatDuration(widget.data['repair_time_no_crew_simulator']),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Text("Crew count"),
                  Text("${widget.data['crew_total_count']}", textAlign: TextAlign.center),
                ],
              ),
              TableRow(
                children: [
                  const Text("Vehicle mass"),
                  Text(
                    "${widget.data['mass']} kg",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          if (['heavy_tank', 'light_tank', 'medium_tank', 'spaa', 'tank_destroyer'].contains(widget.data['vehicle_type']))
            ExpansionTile(
              title: Text("Engine"),
              children: [
                Table(children: [
                  TableRow(
                    children: [
                      const Text("Horse power"),
                      Text(
                        _selectedChip == "AB" ? "${widget.data['engine']["horse_power_ab"]} hp" : "${widget.data['engine']['horse_power_rb_sb']} hp",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("Max. speed"),
                      Text(
                        _selectedChip == "AB" ? "${widget.data['engine']['max_speed_ab']} km/h" : "${widget.data['engine']['max_speed_rb_sb']} km/h",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("Reverse speed"),
                      Text(
                        _selectedChip == "AB"
                            ? "${widget.data['engine']['max_reverse_speed_ab']} km/h"
                            : "${widget.data['engine']['max_reverse_speed_rb_sb']} km/h",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("Max- RPM"),
                      Text(
                        "${widget.data['engine']['max_rpm']}",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("Min. RPM"),
                      Text(
                        "${widget.data['engine']['min_rpm']}",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ])
              ],
            )
        ],
      ),
    );
  }

  String formatDuration(double hours) {
    int totalMinutes = (hours * 60).round();
    int days = totalMinutes ~/ (24 * 60);
    int hoursLeft = (totalMinutes % (24 * 60)) ~/ 60;
    int minutes = totalMinutes % 60;

    String daysStr = days > 0 ? "$days day${days > 1 ? 's' : ''} " : "";
    String hoursStr = hoursLeft > 0 ? "$hoursLeft hour${hoursLeft > 1 ? 's' : ''} " : "";
    String minutesStr = minutes > 0 ? "$minutes minute${minutes > 1 ? 's' : ''}" : "";

    return "$daysStr$hoursStr$minutesStr".trim();
  }
}
