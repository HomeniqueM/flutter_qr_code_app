import 'package:flutter/material.dart';
import 'package:flutter_qr_code_app/src/screens/listScree/components/edit_note_screen.dart';
import 'package:flutter_qr_code_app/src/models/qrdata_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_qr_code_app/src/helpers/database_helpers.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  // Definições
  Future<List<QrData>> _qrDataList;
  final DateFormat _dateFormatter =
      DateFormat('dd.MM.yyyy'); // Formatação de Datas
  @override
  void initState() {
    super.initState();
    _updateList();
  }

  _updateList() {
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _qrDataList = DataBaseHelper.instance.getQrDatafaList();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _qrDataList,
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return _TileQrData(snapshot.data[index ]);
              },
            );
          }),
    );
  }

  Widget _TileQrData(QrData qrData) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              qrData.qrData.length > 25
                  ? '${qrData.qrData.substring(0, 25)}...'
                  : qrData.qrData,
              style: TextStyle(fontSize: 20.0, color: Colors.grey[700]),
            ),
            subtitle: Text(
              'Criando em ${_dateFormatter.format(qrData.data)}',
              style: TextStyle(fontSize: 15.0),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditNote(
                  qrdata: qrData,
                ),
              ),
            ).then((value) => _updateList()),
          ),
          Divider(
            color: Colors.deepPurple[100],
          ),
        ],
      ),
    );
  }
}
