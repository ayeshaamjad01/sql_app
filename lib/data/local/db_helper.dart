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

  /// creating variables for table names and columns

  /// notes table
  static final String TABLE_NOTE = "note";
  static final String COLUMN_NOTE_SNO = "s_no";
  static final String COLUMN_NOTE_TITLE = "title";
  static final String COLUMN_NOTE_DESC = "desc";

  // making it nullable , this means it can be null
  Database? appDB;

  /// db Open (path -> if exists open, else create)
  Future<Database> getDB() async {
    /// ?? means (if null) return appDB , if its null then return openDB()
    ///return appDB ?? await openDB();
    ///or do it in this way
    appDB ??= await openDB();
    return appDB!;

    // if (appDB != null) {
    //   return appDB!;
    // } else {
    //   appDB = await openDB();
    //   return appDB!;
    // }
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "noteDB.db");
    return await openDatabase(dbPath, onCreate: (db, version) {
      ///create all your tables here
      ///you can do this way also to create a table and its columns,
      ///but it will get complex so making variables is the best choice
      // db.execute(
      //     "create table note (s_no integer primary key autoincrement, title text, desc text)");
      db.execute(
          "create table $TABLE_NOTE ($COLUMN_NOTE_SNO integer primary key autoincrement, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text)");
    }, version: 1);
  }

  /// all queries
  /// insertion query
  Future<bool> addNote(
      {required String note_title, required String note_desc}) async {
    var db = await getDB();

    int rowsEffected = await db.insert(TABLE_NOTE, {
      COLUMN_NOTE_TITLE: note_title,
      COLUMN_NOTE_DESC: note_desc,
    });
    return rowsEffected > 0;
  }
}
