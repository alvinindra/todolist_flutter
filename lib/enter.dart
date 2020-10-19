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
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Judul',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: descController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          tooltip: 'Simpan',
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
      );
  }
}
