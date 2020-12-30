import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';

import 'package:flutter_qr_code_app/src/models/qrdata_model.dart';
import 'package:flutter_qr_code_app/src/screens/addAndEditScrees/add_edit_screen.dart';
import 'package:flutter_qr_code_app/src/screens/listScree/list_scree.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "QR Data",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
          ),
          bottom: TabBar(
            // Abas de agenda
            tabs: <Widget>[
              Tab(
                text: 'Ler ou criar',
                icon: Icon(Icons.qr_code),
              ),
              Tab(
                text: 'Notas',
                icon: Icon(Icons.note_add_outlined),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AddEditScreen(),
            ListScreen(),
          ],
        ),
      ),
    );
  }

  Widget flatButon(String text, Widget widget) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: FlatButton(
        color: Colors.deepPurple,
        padding: EdgeInsets.all(15.0),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => widget));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Theme.of(context).primaryColor, width: 3.0),
        ),
      ),
    );
  }
}
