import 'dart:async';
import 'dart:ui';

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

  ListTile rowItem(Todo todo) {
    return ListTile(
      title: Text(
        todo.title,
      ),
      subtitle: Text(todo.desc.toString()),
      onTap: () async {
        var todo2 = await navigateToEntryForm(context, todo);
        if (todo2 != null) {
          int result = await dbHelper.update(todo2);
          if (result > 0) {
            updateListView();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'ToDoList',
          style: TextStyle(fontWeight: FontWeight.w600),
        )),
      ),
      body: FutureBuilder<List<Todo>>(
        future: future,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data.length == 0) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('images/img_no_task.png')),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        "Tidak Ada Tugas",
                        style: TextStyle(
                            color: Color(0xff29A19C),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      "Ayo buat tugas untuk hari ini!",
                      style: TextStyle(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Todo todo = snapshot.data[index];

                return Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(color: Colors.blue),
                    secondaryBackground: Container(color: Colors.red),
                    key: Key(todo.title),
                    onDismissed: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        snapshot.data.removeAt(index);
                        int result = await dbHelper.delete(todo);
                        if (result > 0) {
                          updateListView();
                        }
                      }
                    },
                    child: Column(
                      children: <Widget>[rowItem(todo)],
                    ));
              },
            );
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
                          color:
                              currentTab == 1 ? Color(0xff29A19C) : Colors.grey,
                        ),
                        Text(
                          'List',
                          style: TextStyle(
                            color: currentTab == 1
                                ? Color(0xff29A19C)
                                : Colors.grey,
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
                      setState(() {
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color:
                              currentTab == 2 ? Color(0xff29A19C) : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: currentTab == 2
                                ? Color(0xff29A19C)
                                : Colors.grey,
                          ),
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
