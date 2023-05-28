import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../model/task.dart';

class DbHelper {
  static Database? _db;
  static const int _vertsion = 1;
  static const String _tableName = "tasks";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }

    try {
      String path = '${await getDatabasesPath()}task.db';

      _db = await openDatabase(path, version: _vertsion,
          onCreate: ((db, version) {
        return db.execute("CREATE TABLE $_tableName"
            "(id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, note TEXT, date STRING, "
            "startTime STRING, endTime STRING, "
            "remind INTEGER, repeat STRING, "
            "color INTEGER, isCompleted INTEGER)");
      }));
    } catch (e) {
      debugPrint("exception happend db $e");
    }
  }

  static Future<int> insert(Task? task) async {
    debugPrint("insert() called");
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    debugPrint("query called");
    return await _db!.query(_tableName);
  }

  static delete(Task task) async {
    await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id) async {
    debugPrint("update called");
    return await _db!.rawUpdate('''
UPDATE tasks
SET isCompleted = ?
WHERE id =?
''', [1, id]);
  }

  static editTask(Task task) async {
    try {
      debugPrint(task.id.toString());
      var count = await _db!.update(_tableName, task.toJson(),
          where: 'id=?', whereArgs: [task.id]);
      debugPrint(count.toString());
    } catch (e) {
      debugPrint("edit task called");
      debugPrint("error is $e");
    }
  }
}
