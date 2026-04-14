import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SqlDatabase {
  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await init();
      return _database!;
    } else {
      return _database!;
    }
  }

  init() async {
    Database myDatabase = await openDatabase('Database.db',
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return myDatabase;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE TableName (id INTEGER PRIMARY KEY, name TEXT, phone TEXT, score INTEGER, date TEXT)');
    debugPrint('------------------ Table Created ------------------');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    debugPrint('------------------ Table Created ------------------');
  }

  Future<List<Map>> readFromDatabase(String sql) async {
    Database? myDatabase = await database;
    var res = await myDatabase!.rawQuery(sql);
    return res;
  }

  void updateInDatabase(String sql) async {
    Database? myDatabase = await database;
    await myDatabase!.rawUpdate(sql);
  }

  void insertToDatabase({required String sql, List<dynamic>? args}) async {
    Database? myDatabase = await database;
    await myDatabase!.rawInsert(sql, args);
  }

  void deleteFromDatabase(String sql) async {
    Database? myDatabase = await database;
    await myDatabase!.rawDelete(sql);
  }
}
