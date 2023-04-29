// ignore_for_file: file_names, avoid_print, non_constant_identifier_names

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  final String db_Name = 'note.db';
  final String tb_Name = 'notes';
  final String col_Id = 'id';
  final String col_Title = 'title';
  final String col_Note = 'note';

  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  initialDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, db_Name);
    Database myDb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return myDb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    print("onUpgrade ========================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "$tb_Name" (
        "$col_Id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "$col_Title" TEXT NOT NULL,
        "$col_Note" TEXT NOT NULL
      )
    ''');
    print('onCreate ========================');
  }

  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  deletingDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, db_Name);
    await deleteDatabase(path);
  }


  ////////////// Shorthand /////////////////

  read(String table) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.query(table);
    return response;
  }

  insert(String table, Map<String, Object?> values) async {
    Database? myDb = await db;
    int response = await myDb!.insert(table, values);
    return response;
  }

  update(String table, Map<String, Object?> value, String? myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.update(table, value,where: myWhere);
    return response;
  }

  delete(String table, String? myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.delete(table, where: myWhere);
    return response;
  }

}

