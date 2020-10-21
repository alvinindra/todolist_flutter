import 'package:sqflite/sqflite.dart';

import '../local/access_database.dart';
import '../model/todo.dart';

class CRUD {
  static const todoTable = 'todo';
  static const id = 'id';
  static const title = 'title';
  static const desc = 'desc';
  AccessDatabase dbHelper = new AccessDatabase();

  Future<int> insert(Todo todo) async {
    Database db = await dbHelper.initDb();
    int count = await db.insert('todo', todo.toMap());
    return count;
  }

  Future<int> update(Todo todo) async {
    Database db = await dbHelper.initDb();
    int count = await db
        .update('todo', todo.toMap(), where: 'id=?', whereArgs: [todo.id]);
    return count;
  }

  Future<int> delete(Todo todo) async {
    Database db = await dbHelper.initDb();
    int count = await db.delete('todo', where: 'id=?', whereArgs: [todo.id]);
    return count;
  }

  Future<List<Todo>> getTodoList() async {
    Database db = await dbHelper.initDb();
    List<Map<String, dynamic>> mapList =
        await db.query('todo', orderBy: 'title');
    int count = mapList.length;
    List<Todo> todoList = List<Todo>();
    for (int i = 0; i < count; i++) {
      todoList.add(Todo.fromMap(mapList[i]));
    }
    return todoList;
  }
}
