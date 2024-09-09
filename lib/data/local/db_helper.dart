import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  ///singleton
  DBHelper._();
  static DBHelper getInstance() {
    return DBHelper._();
  }

  // making it nullable , this means it can be null
  Database? appDB;

  /// db Open (path -> if exists open, else create)
  Future<Database> getDB() async {
    if (appDB != null) {
      return appDB!;
    } else {
      appDB = await openDB();
      return appDB!;
    }
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "noteDB.db");
    return await openDatabase(dbPath, onCreate: (db, version) {
      ///create all your tables here
      ///
    }, version: 1);
  }

  /// all queries
  ///
}
