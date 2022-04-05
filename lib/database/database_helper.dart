import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
class DatabaseHelper {


  static const _databaseName = "StokeManagement.db";
  static final _databaseVersion = 1;

  static const table = 'vendor_table';
  static const columnId = 'vendor_id';
  static const columnFirstName = 'vendor_firstname';
  static const columnLastName = 'vendor_lastname';
  static const columnMobileNumber = 'vendor_mobilenumber';
  static const columnCompanyName = 'vendor_companyname';
  static const columnAddress = 'vendor_address';
  static const columnEmail = 'vendor_email';



  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = new DatabaseHelper._privateConstructor();

  Database? _database = null;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }


  static Future<List<Map<String, dynamic>>> getVendor() async {
    Database? db = await instance.database;
    var result = await db!.query(table);
    return result.toList();
  }


  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnFirstName TEXT NOT NULL,
            $columnLastName TEXT NOT NULL,
            $columnMobileNumber TEXT NOT NULL
            $columnCompanyName TEXT NOT NULL
            $columnAddress TEXT NOT NULL
            $columnEmail TEXT NOT NULL
            
          )
          ''');
  }


  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }


  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    var result = await db!.query(table);
    return result.toList();
  }

  Future<int> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  }


  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }


  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

}
