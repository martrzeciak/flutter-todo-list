import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DB {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "tasks";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = await getDatabasesPath() + 'tasks.db';
      _db =
          await openDatabase(path, version: _version, onCreate: (db, vesion) {
        print("Creating new databas");
        return db.execute("CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title TEXT, description TEXT, date STRING, "
            "startTime STRING, endTime STRING, "
            "priority INTEGER, isCompleted INTEGER)");
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print("Insert function called");
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("Query function called");
    return await _db!.query(_tableName);
  }

  static Future<int> update(Task task) async {
    print("Update function called");
    return await _db!.update(_tableName, task.toJson(),
        where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<int> updateStatus(int taskId) async {
    print("Update isCompleted function called");
    final updatedRows = await _db!.update(
      _tableName,
      {'isCompleted': 1},
      where: 'id = ?',
      whereArgs: [taskId],
    );
    return updatedRows;
  }

  static Future<int> delete(Task task) async {
    print("Delete function called");
    return await _db!.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  static Future<int> deleteAll() async {
    print("Delete all function called");
    return await _db!.delete(_tableName);
  }
}
