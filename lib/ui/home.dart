import 'dart:async';

import 'package:flutter/material.dart';

import '../local/crud.dart';
import '../model/todo.dart';
import 'enter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CRUD dbHelper = CRUD();
  Future<List<Todo>> future;

  int currentTab = 1;

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

  Future<Todo> navigateToEntryForm(BuildContext context, Todo todo) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(todo);
    }));
    return result;
  }

  Card cardo(Todo todo) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
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
      body: FutureBuilder<List<Todo>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Todo todo = snapshot.data[index];
                return Column(
                  children: <Widget>[cardo(todo)],
                );
              },
            );
          } else {
            return SizedBox();
          }
        },
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.book,
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'List',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Right Tab bar icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 60,
                    onPressed: () {
                      setState(() {});
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
