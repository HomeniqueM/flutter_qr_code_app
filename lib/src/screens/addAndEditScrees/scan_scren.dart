import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_qr_code_app/src/helpers/database_helpers.dart';
import 'package:flutter_qr_code_app/src/models/qrdata_model.dart';
import 'package:flutter_qr_code_app/src/helpers/database_helpers.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String qrResult = "Nada procurando ainda...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ler QR Code"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: _addQrData,
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "O que foi obtido ",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              qrResult,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: FlatButton(
                padding: EdgeInsets.all(15),
                child: Text("Ler outro QR Code"),
                onPressed: () async {
                  String scaning = await BarcodeScanner.scan();
                  setState(() {
                    qrResult = scaning;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                      color: Theme.of(context).primaryColor, width: 3.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _addQrData() {
    QrData qrdata =
        QrData(comentario: '', qrData: qrResult, data: DateTime.now());
    DataBaseHelper.instance.insertqrData(qrdata);
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('QR Code savo',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),),
          backgroundColor: Colors.green,
        ),
      );
    });
    print("Save");
  }
}
