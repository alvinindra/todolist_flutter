import 'package:sqflite/sqflite.dart';
import 'class_catcher.dart';
import 'access_database.dart';

class CRUD {
  static const todoTable = 'todo';
  static const id = 'id';
  static const title = 'title';
  static const desc = 'desc';
  AccessDatabase dbHelper = new AccessDatabase();

  Future<int> insert(ClassCatcher todo) async {
    Database db = await dbHelper.initDb();
    int count = await db.insert('todo', todo.toMap());
    return count;
  }

  Future<int> update(ClassCatcher todo) async {
    Database db = await dbHelper.initDb();
    int count = await db
        .update('todo', todo.toMap(), where: 'id=?', whereArgs: [todo.id]);
    return count;
  }

  Future<int> delete(ClassCatcher todo) async {
    Database db = await dbHelper.initDb();
    int count = await db.delete('todo', where: 'id=?', whereArgs: [todo.id]);
    return count;
  }

  Future<List<ClassCatcher>> getTodoList() async {
    Database db = await dbHelper.initDb();
    List<Map<String, dynamic>> mapList =
        await db.query('todo', orderBy: 'title');
    int count = mapList.length;
    List<ClassCatcher> todoList = List<ClassCatcher>();
    for (int i = 0; i < count; i++) {
      todoList.add(ClassCatcher.fromMap(mapList[i]));
    }
    return todoList;
  }
}
