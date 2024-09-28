import 'dart:io';

import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter_wt_wiki/classes/synthetic_vehicle.dart';
import 'package:flutter_wt_wiki/classes/vehicle.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = join(await getDatabasesPath(), 'vehiclesdb.sqlite3');
    await _copyDatabaseFromAssets(dbPath);
    return await openDatabase(dbPath);
  }

  Future<void> _copyDatabaseFromAssets(String dbPath) async {
    if (File(dbPath).existsSync()) {
      return;
    }

    try {
      await Directory(dirname(dbPath)).create(recursive: true);
    } catch (e) {
      print("Error creating directory: $e");
    }

    // Copy the database from the assets
    ByteData data = await rootBundle.load('assets/vehiclesdb.sqlite3');
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes, flush: true);
  }

  Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SyntheticVehicle>> getSyntheticVehiclesByFilters(String table, String whereClause, List<dynamic> whereArgs) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      table,
      where: whereClause,
      whereArgs: whereArgs,
    );

    return List.generate(maps.length, (i) {
      return SyntheticVehicle.fromMap(maps[i]);
    });
  }

  Future<Vehicle?> getVehicleById(String table, String identifier) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      table,
      where: 'identifier = ?',
      whereArgs: [identifier],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return Vehicle.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> update(String table, Map<String, dynamic> data, String whereClause, List<dynamic> whereArgs) async {
    final db = await database;
    return await db.update(
      table,
      data,
      where: whereClause,
      whereArgs: whereArgs,
    );
  }

  Future<int> delete(String table, String whereClause, List<dynamic> whereArgs) async {
    final db = await database;
    return await db.delete(
      table,
      where: whereClause,
      whereArgs: whereArgs,
    );
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
