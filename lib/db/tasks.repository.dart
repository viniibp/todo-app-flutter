import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/services/database.service.dart';
import 'package:todoapp/models/task.model.dart';

class TasksDB {
  final tableName = 'tasks';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL,
      "description" TEXT NOT NULL,
      "executionTime" INTEGER,
      "ended" BOOLEAN DEFAULT 0,
      PRIMARY KEY("id" AUTOINCREMENT)
    );""");
  }

  Future<int> create(Task task) async {
    final database = await DatabaseService().database;
    try {
      final res = await database.rawInsert(
          '''INSERT INTO $tableName (description, executionTime) VALUES (?,?);''',
          [
            task.description,
            task.executionDate.millisecondsSinceEpoch,
          ]);
      return res;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    } finally {
      database.close();
    }
  }

  Future<List<Task>> fetchAll() async {
    final database = await DatabaseService().database;
    try {
      final tasks =
          await database.query(tableName, orderBy: 'executionTime DESC');
      if (tasks.isEmpty) return [];
      return tasks.map((task) => Task.fromSqfliteDatabase(task)).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    } finally {
      database.close();
    }
  }

  Future<int> update(Task task) async {
    final database = await DatabaseService().database;
    try {
      return await database.update(
        tableName,
        {
          'description': task.description,
          'executionTime': task.executionDate.millisecondsSinceEpoch,
          'ended': task.ended == true ? 1 : 0,
        },
        where: 'id = ?',
        whereArgs: [task.id],
        conflictAlgorithm: ConflictAlgorithm.rollback,
      );
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    } finally {
      database.close();
    }
  }

  Future<void> delete({required int id}) async {
    final database = await DatabaseService().database;
    try {
      await database.delete(tableName, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      database.close();
    }
  }
}
