import 'package:flutter/material.dart';

import 'ui/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tambahkan Daftar',
      theme: ThemeData(
          primaryColor: Color(0xff29A19C),
          primarySwatch: Colors.teal,
          fontFamily: 'Poppins'),
      home: Home(),
    );
  }
}
