import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/classes/vehicle.dart';
import 'package:flutter_wt_wiki/constants.dart';
import 'package:flutter_wt_wiki/utils.dart';

class EconomyTable extends StatefulWidget {
  final Vehicle dbVehicle;

  const EconomyTable({super.key, required this.dbVehicle});

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
        child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ChoiceChip(
            label: const Text("AB"),
            selected: _selectedChip == "AB",
            elevation: 4,
            onSelected: (bool selected) {
              setState(() {
                _selectedChip = "AB";
              });
            }),
        ChoiceChip(
            label: const Text("RB"),
            selected: _selectedChip == "RB",
            onSelected: (bool selected) {
              setState(() {
                _selectedChip = "RB";
              });
            }),
        if (!Constants.fleetVehicleTypes.contains(widget.dbVehicle.vehicleType))
          ChoiceChip(
              label: const Text("SB"),
              selected: _selectedChip == "SB",
              onSelected: (bool selected) {
                setState(() {
                  _selectedChip = "SB";
                });
              })
      ]),
      Padding(
          padding: const EdgeInsets.all(8),
          child: Table(children: [
            TableRow(children: [
              const Text("SL bonus:"),
              Text(
                  _selectedChip == "AB"
                      ? "${(widget.dbVehicle.slMulArcade * 100).round()}%"
                      : _selectedChip == "RB"
                          ? "${(widget.dbVehicle.slMulRealistic * 100).round()}%"
                          : "${(widget.dbVehicle.slMulSimulator * 100).round()}%",
                  textAlign: TextAlign.center)
            ]),
            TableRow(
              children: [const Text("RP bonus:"), Text("${(widget.dbVehicle.expMul * 100).round()}%", textAlign: TextAlign.center)],
            ),
            TableRow(children: [
              const Text("Repair cost:"),
              Text(
                  _selectedChip == "AB"
                      ? "${formatBigNumber(widget.dbVehicle.repairCostArcade)} €"
                      : _selectedChip == "RB"
                          ? "${formatBigNumber(widget.dbVehicle.repairCostRealistic)} €"
                          : "${formatBigNumber(widget.dbVehicle.repairCostSimulator)} €",
                  textAlign: TextAlign.center)
            ]),
            TableRow(children: [
              const Text("Repair cost/min:"),
              Text(
                  _selectedChip == "AB"
                      ? "${formatBigNumber(widget.dbVehicle.repairCostPerMinArcade)} €"
                      : _selectedChip == "RB"
                          ? "${formatBigNumber(widget.dbVehicle.repairCostPerMinRealistic)} €"
                          : "${formatBigNumber(widget.dbVehicle.repairCostPerMinSimulator)} €",
                  textAlign: TextAlign.center)
            ]),
            TableRow(children: [
              const Text("Repair cost (spaded):"),
              Text(
                  _selectedChip == "AB"
                      ? "${formatBigNumber(widget.dbVehicle.repairCostFullUpgradedArcade)} €"
                      : _selectedChip == "RB"
                          ? "${formatBigNumber(widget.dbVehicle.repairCostFullUpgradedRealistic)} €"
                          : "${formatBigNumber(widget.dbVehicle.repairCostFullUpgradedSimulator)} €",
                  textAlign: TextAlign.center)
            ]),
            TableRow(children: [
              const Text("Repair time:"),
              Text(
                  _selectedChip == "AB"
                      ? formatDuration(widget.dbVehicle.repairTimeArcade)
                      : _selectedChip == "RB"
                          ? formatDuration(widget.dbVehicle.repairTimeRealistic)
                          : formatDuration(widget.dbVehicle.repairTimeSimulator),
                  textAlign: TextAlign.center)
            ]),
            TableRow(children: [
              const Text("Repair time (no crew):"),
              Text(
                  _selectedChip == "AB"
                      ? formatDuration(widget.dbVehicle.repairTimeNoCrewArcade)
                      : _selectedChip == "RB"
                          ? formatDuration(widget.dbVehicle.repairTimeNoCrewRealistic)
                          : formatDuration(widget.dbVehicle.repairTimeNoCrewSimulator),
                  textAlign: TextAlign.center)
            ]),
            TableRow(children: [const Text("Crew count:"), Text("${widget.dbVehicle.crewTotalCount}", textAlign: TextAlign.center)]),
            TableRow(children: [const Text("Vehicle mass:"), Text("${widget.dbVehicle.mass} kg", textAlign: TextAlign.center)])
          ])),
      //TODO: Modularize this
      ExpansionTile(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), title: const Text("Engine"), children: [
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: Table(children: [
              if (Constants.groundVehicleTypes.contains(widget.dbVehicle.vehicleType))
                TableRow(children: [
                  const Text("Horse power:"),
                  Text(_selectedChip == "AB" ? "${widget.dbVehicle.engine!.horsePowerAb} hp" : "${widget.dbVehicle.engine!.horsePowerRbSb} hp", textAlign: TextAlign.center)
                ]),
              TableRow(children: [
                const Text("Max. speed:"),
                Text(_selectedChip == "AB" ? "${widget.dbVehicle.engine!.maxSpeedAb} km/h" : "${widget.dbVehicle.engine!.maxSpeedRbSb} km/h", textAlign: TextAlign.center)
              ]),
              TableRow(children: [
                const Text("Reverse speed:"),
                Text(_selectedChip == "AB" ? "${widget.dbVehicle.engine!.maxReverseSpeedAb} km/h" : "${widget.dbVehicle.engine!.maxReverseSpeedRbSb} km/h", textAlign: TextAlign.center)
              ]),
              if (Constants.groundVehicleTypes.contains(widget.dbVehicle.vehicleType)) ...[
                TableRow(children: [const Text("Max. RPM:"), Text("${widget.dbVehicle.engine!.maxRpm}", textAlign: TextAlign.center)]),
                TableRow(children: [const Text("Min. RPM:"), Text("${widget.dbVehicle.engine!.minRpm}", textAlign: TextAlign.center)])
              ],
            ]))
      ]),
      //TODO: Modularize this
      ExpansionTile(title: const Text("Crew training costs"), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(children: [
              TableRow(children: [const Text("Crew 1 cost"), Text("${formatBigNumber(widget.dbVehicle.train1Cost)} €", textAlign: TextAlign.center)]),
              TableRow(children: [const Text("Crew 2 cost"), Text("${formatBigNumber(widget.dbVehicle.train2Cost)} €", textAlign: TextAlign.center)]),
              TableRow(children: [const Text("Crew 3 cost (gold)"), Text("${formatBigNumber(widget.dbVehicle.train3CostGold)} ¤", textAlign: TextAlign.center)]),
              TableRow(children: [const Text("Crew 4 cost (exp)"), Text("${formatBigNumber(widget.dbVehicle.train3CostExp)} ▉", textAlign: TextAlign.center)]),
            ]))
      ])
    ]));
  }
}
