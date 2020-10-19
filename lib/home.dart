import 'package:flutter/material.dart';
import 'dart:async';
import 'crud.dart';
import 'class_catcher.dart';
import 'enter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CRUD dbHelper = CRUD();
  Future<List<ClassCatcher>> future;
  @override
  void initState() {
    super.initState();
    updateListView();
  }

  void updateListView() {
    setState(() {
      future = dbHelper.getTodoList();
    });
  }

  Future<ClassCatcher> navigateToEntryForm(
      BuildContext context, ClassCatcher todo) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(todo);
    }));
    return result;
  }

  Card cardo(ClassCatcher todo) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(
          todo.title,
        ),
        subtitle: Text(todo.desc.toString()),
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        trailing: GestureDetector(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete),
            ],
          ),
          onTap: () async {
            int result = await dbHelper.delete(todo);
            if (result > 0) {
              updateListView();
            }
          },
        ),
        onTap: () async {
          var todo2 = await navigateToEntryForm(context, todo);
          if (todo2 != null) {
            int result = await dbHelper.update(todo2);
            if (result > 0) {
              updateListView();
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FutureBuilder<List<ClassCatcher>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                  children: snapshot.data.map((todo) => cardo(todo)).toList());
            } else {
              return SizedBox();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Tambah Data',
        onPressed: () async {
          var todo = await navigateToEntryForm(context, null);
          if (todo != null) {
            int result = await dbHelper.insert(todo);
            if (result > 0) {
              updateListView();
            }
          }
        },
      ),
    );
  }
}
