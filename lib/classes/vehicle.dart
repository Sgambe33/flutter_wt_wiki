import 'dart:convert';

import 'package:flutter_wt_wiki/classes/aerodynamics.dart';
import 'package:flutter_wt_wiki/classes/ballistic_computer.dart';
import 'package:flutter_wt_wiki/classes/customizable_preset.dart';
import 'package:flutter_wt_wiki/classes/engine.dart';
import 'package:flutter_wt_wiki/classes/modification.dart';
import 'package:flutter_wt_wiki/classes/night_vision_device.dart';
import 'package:flutter_wt_wiki/classes/preset.dart';
import 'package:flutter_wt_wiki/classes/synthetic_vehicle.dart';
import 'package:flutter_wt_wiki/classes/weapon.dart';

class Vehicle extends SyntheticVehicle{
  List<String> vehicleSubTypes;
  String? event;
  String? releaseDate;
  String? version;
  num arcadeBr;
  num realisticBr;
  num realisticGroundBr;
  num simulatorBr;
  num simulatorGroundBr;
  num value;
  num reqExp;
  bool isPremium;
  bool isPack;
  bool onMarketplace;
  bool squadronVehicle;
  num geCost;
  num crewTotalCount;
  num visibility;
  List<num> hullArmor;
  List<num> turretArmor;
  num mass;
  num train1Cost;
  num train2Cost;
  num train3CostGold;
  num train3CostExp;
  num slMulArcade;
  num slMulRealistic;
  num slMulSimulator;
  num expMul;
  num repairTimeArcade;
  num repairTimeRealistic;
  num repairTimeSimulator;
  num repairTimeNoCrewArcade;
  num repairTimeNoCrewRealistic;
  num repairTimeNoCrewSimulator;
  num repairCostArcade;
  num repairCostRealistic;
  num repairCostSimulator;
  num repairCostPerMinArcade;
  num repairCostPerMinRealistic;
  num repairCostPerMinSimulator;
  num repairCostFullUpgradedArcade;
  num repairCostFullUpgradedRealistic;
  num repairCostFullUpgradedSimulator;
  String? requiredVehicle;
  Engine? engine;
  List<Modification> modifications;
  NightVisionDevice? irDevices;
  NightVisionDevice? thermalDevices;
  BallisticComputer? ballisticComputer;
  Aerodynamics? aerodynamics;
  List<Weapon> weapons;
  bool hasCustomizableWeapons;
  List<Preset> presets;
  CustomizablePreset? customizablePresets;

  Vehicle({
    super.country,
    super.identifier,
    super.vehicleType,
    super.era = 1,
    this.vehicleSubTypes = const [],
    this.event,
    this.releaseDate,
    this.version,
    this.arcadeBr = 1.0,
    this.realisticBr = 1.0,
    this.realisticGroundBr = 1.0,
    this.simulatorBr = 1.0,
    this.simulatorGroundBr = 1.0,
    this.value = 0,
    this.reqExp = 0,
    this.isPremium = false,
    this.isPack = false,
    this.onMarketplace = false,
    this.squadronVehicle = false,
    this.geCost = 0,
    this.crewTotalCount = 0,
    this.visibility = 0,
    this.hullArmor = const [],
    this.turretArmor = const [],
    this.mass = 0.0,
    this.train1Cost = 0,
    this.train2Cost = 0,
    this.train3CostGold = 0,
    this.train3CostExp = 0,
    this.slMulArcade = 0.0,
    this.slMulRealistic = 0.0,
    this.slMulSimulator = 0.0,
    this.expMul = 0.0,
    this.repairTimeArcade = 0.0,
    this.repairTimeRealistic = 0.0,
    this.repairTimeSimulator = 0.0,
    this.repairTimeNoCrewArcade = 0.0,
    this.repairTimeNoCrewRealistic = 0.0,
    this.repairTimeNoCrewSimulator = 0.0,
    this.repairCostArcade = 0,
    this.repairCostRealistic = 0,
    this.repairCostSimulator = 0,
    this.repairCostPerMinArcade = 0,
    this.repairCostPerMinRealistic = 0,
    this.repairCostPerMinSimulator = 0,
    this.repairCostFullUpgradedArcade = 0,
    this.repairCostFullUpgradedRealistic = 0,
    this.repairCostFullUpgradedSimulator = 0,
    this.requiredVehicle,
    this.engine,
    this.modifications = const [],
    this.irDevices,
    this.thermalDevices,
    this.ballisticComputer,
    this.aerodynamics,
    this.weapons = const [],
    this.hasCustomizableWeapons = false,
    this.presets = const [],
    this.customizablePresets,
  });

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      country: map['country'],
      identifier: map['identifier'],
      vehicleType: map['vehicle_type'],
      vehicleSubTypes: map['vehicle_sub_types'] is String ? [map['vehicle_sub_types']] : List<String>.from(map['vehicle_sub_types'] ?? []),
      event: map['event'],
      releaseDate: map['release_date'],
      version: map['version'],
      era: map['era'] ?? 0,
      arcadeBr: map['arcade_br'] ?? 1.0,
      realisticBr: map['realistic_br'] ?? 1.0,
      realisticGroundBr: map['realistic_ground_br'] ?? 1.0,
      simulatorBr: map['simulator_br'] ?? 1.0,
      simulatorGroundBr: map['simulator_ground_br'] ?? 1.0,
      value: map['value'] ?? 0,
      reqExp: map['req_exp'] ?? 0,
      isPremium: map['is_premium'] == 1,
      isPack: map['is_pack'] == 1,
      onMarketplace: map['on_marketplace'] == 1,
      squadronVehicle: map['squadron_vehicle'] == 1,
      geCost: map['ge_cost'] ?? 0,
      crewTotalCount: map['crew_total_count'] ?? 0,
      visibility: map['visibility'] ?? 0,
      hullArmor: map['hull_armor'] != "[]" ? List<num>.from(jsonDecode(map['hull_armor']) as List<dynamic>) : [],
      turretArmor: map['turret_armor'] != "[]" ? List<num>.from(jsonDecode(map['turret_armor']) as List<dynamic>) : [],
      mass: map['mass'] ?? 0.0,
      train1Cost: map['train1_cost'] ?? 0,
      train2Cost: map['train2_cost'] ?? 0,
      train3CostGold: map['train3_cost_gold'] ?? 0,
      train3CostExp: map['train3_cost_exp'] ?? 0,
      slMulArcade: map['sl_mul_arcade'] ?? 0.0,
      slMulRealistic: map['sl_mul_realistic'] ?? 0.0,
      slMulSimulator: map['sl_mul_simulator'] ?? 0.0,
      expMul: map['exp_mul'] ?? 0.0,
      repairTimeArcade: map['repair_time_arcade'] ?? 0.0,
      repairTimeRealistic: map['repair_time_realistic'] ?? 0.0,
      repairTimeSimulator: map['repair_time_simulator'] ?? 0.0,
      repairTimeNoCrewArcade: map['repair_time_no_crew_arcade'] ?? 0.0,
      repairTimeNoCrewRealistic: map['repair_time_no_crew_realistic'] ?? 0.0,
      repairTimeNoCrewSimulator: map['repair_time_no_crew_simulator'] ?? 0.0,
      repairCostArcade: map['repair_cost_arcade'] ?? 0,
      repairCostRealistic: map['repair_cost_realistic'] ?? 0,
      repairCostSimulator: map['repair_cost_simulator'] ?? 0,
      repairCostPerMinArcade: map['repair_cost_per_min_arcade'] ?? 0,
      repairCostPerMinRealistic: map['repair_cost_per_min_realistic'] ?? 0,
      repairCostPerMinSimulator: map['repair_cost_per_min_simulator'] ?? 0,
      repairCostFullUpgradedArcade: map['repair_cost_full_upgraded_arcade'] ?? 0,
      repairCostFullUpgradedRealistic: map['repair_cost_full_upgraded_realistic'] ?? 0,
      repairCostFullUpgradedSimulator: map['repair_cost_full_upgraded_simulator'] ?? 0,
      requiredVehicle: map['required_vehicle'],
      engine: map['engine'] != null ? Engine.fromMap(jsonDecode(map['engine'])) : null,
      modifications: map['modifications'] != [] ? List<Modification>.from(jsonDecode(map['modifications']).map((x) => Modification.fromMap(x))) : [],
      irDevices: map['ir_devices'] != {} ? NightVisionDevice.fromMap(jsonDecode(map['ir_devices'])) : null,
      thermalDevices: map['thermal_devices'] != null ? NightVisionDevice.fromMap(jsonDecode(map['thermal_devices'])) : null,
      ballisticComputer: map['ballistic_computer'] != null ? BallisticComputer.fromMap(jsonDecode(map['ballistic_computer'])) : null,
      aerodynamics: map['aerodynamics'] != {} ? Aerodynamics.fromMap(jsonDecode(map['aerodynamics'])) : null,
      weapons: map['weapons'] != {} ? List<Weapon>.from(jsonDecode(map['weapons']).map((x) => Weapon.fromMap(x))) : [],
      hasCustomizableWeapons: map['has_customizable_weapons'] == 1,
      presets: map['presets'] != {} ? List<Preset>.from(jsonDecode(map['presets']).map((x) => Preset.fromMap(x))) : [],
      customizablePresets: (jsonDecode(map['customizable_presets']) is List) ? null : CustomizablePreset.fromMap(jsonDecode(map['customizable_presets'])),
    );
  }
}
