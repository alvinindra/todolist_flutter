class Todo {
  int _id;
  String _title;
  String _desc;

  Todo(this._title, this._desc);

  Todo.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._desc = map['desc'];
  }

  int get id => _id;

  String get title => _title;

  String get desc => _desc;

  set title(String value) {
    _title = value;
  }

  set desc(String value) {
    _desc = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['desc'] = desc;
    return map;
  }
}
