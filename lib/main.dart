import 'package:flutter/material.dart';
import 'package:flutter_qr_code_app/src/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leitor de qr-code',
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}
