import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/api_response/melting_data_model.dart';


class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database;

  String datatable = 'data_table';
  String colId = 'id';
  String colweight = 'weight';
  String coltouch = 'touch';
  String coloutput = 'output';
  // String coladd = 'add';
  String coldate = 'date';
  String colpal = 'pal';
  String colfinalweight = 'finalweight';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'data.db';
    print("==path==" + path);
    // Open/create the database at a given path
    var dataDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return dataDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $datatable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colweight TEXT,'
        '$coltouch TEXT,$coloutput TEXT,$colpal TEXT,$colfinalweight TEXT,$coldate TEXT)');
  }

  //fetching
  Future<List<Map<String, dynamic>>?> getdataMapList() async {
    Database? db = await this.database;

    var result = await db?.query(datatable);
    return result;
  }

  //inserting
  Future<int?> insertMeltingData(MeltingDataModel data) async {
    Database? db = await this.database;
    var result = await db?.insert(datatable, data.toMap());
    print("insert done" + data.toMap().toString());
    return result;
  }

  //update
  Future<int?> updateMeltingData(MeltingDataModel data) async {
    print("update done" + data.toMap().toString());
    var db = await this.database;
    var result = await db?.update(datatable, data.toMap(),
        where: '$colId = ?', whereArgs: [data.id]);
    return result;
  }

  //delete
  Future<int> deleteData(int id) async {
    var db = await this.database;
    int total =
        await db!.rawDelete('DELETE FROM $datatable WHERE $colId = $id');
    return total;
  }

  //no of data from db
  Future<int?> getCount() async {
    Database? db = await this.database;
    List<Map<String, dynamic>> x =
        await db!.rawQuery('SELECT COUNT (*) from $datatable');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  //convo of map to list
  Future<List<MeltingDataModel>> getMeltingdataList() async {
    var dataMapList = await getdataMapList(); //  List of database
    int count = dataMapList!.length;

    List<MeltingDataModel> dataList = <MeltingDataModel>[];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      dataList.add(MeltingDataModel.fromMapObject(dataMapList[i]));
      print("hello" + dataList[i].weight.toString());
    }

    return dataList;
  }
}
