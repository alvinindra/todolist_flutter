import 'package:flutter/material.dart';
import 'class_catcher.dart';

class EntryForm extends StatefulWidget {
  final ClassCatcher todo;

  EntryForm(this.todo);

  @override
  _EntryFormState createState() => _EntryFormState(this.todo);
}

class _EntryFormState extends State<EntryForm> {
  ClassCatcher todo;

  _EntryFormState(this.todo);
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    if (todo != null) {
      titleController.text = todo.title;
      descController.text = todo.desc;
    }
    return Scaffold(
        appBar: AppBar(
          title: todo == null ? Text('Tambah') : Text('Ubah'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // nama
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Judul',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: descController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (todo == null) {
                            todo = ClassCatcher(
                                titleController.text, descController.text);
                          } else {
                            todo.title = titleController.text;
                            todo.desc = descController.text;
                          }
                          Navigator.pop(context, todo);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
