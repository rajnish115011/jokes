


import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';

import 'Joke.dart';

class DbHelper {
  String tbljoke = "joke";
  String colId = "Id";
  String colDescription = "joke";

  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "Test.db";
    var dbEcommerce = await openDatabase(path, onCreate: _createDb, version: 1);
    return dbEcommerce;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        "Create table $tbljoke($colId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $colDescription text)");
  }

  Future<int> insert(Joke joke) async {
    Database? db = await this.db;
    var result = await db!.insert(tbljoke, joke.toMap());
    return result;
  }



  Future<List<Joke>> getProducts() async {
    List<Joke>list=[];

    Database? db = await this.db;
    List result = await db!.rawQuery("Select * from $tbljoke order by $colId DESC LIMIT 10");
    for (int i = 0; i < result.length; i++) {
      list.add(Joke.fromObject(result[i]));
    }
    final List<Joke> reversedList = List.from(list.reversed);
    return reversedList;
  }
}