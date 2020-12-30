import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  String _qrData = "Trabalho Final LDDM";
  String _texto = "Trabalho Final LDDM";
  final _formKey = GlobalKey<FormState>();

  GlobalKey globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar QR Code"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _captureAndSharePng,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RepaintBoundary(
                key: globalKey,
                child: QrImage(data: _qrData),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "insira um texto para ser convertido",
                textAlign: TextAlign.center,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: TextFormField(
                        maxLines: 5,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Texto',
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (input) => input.trim().isEmpty
                            ? 'Porfavor,Digite Algum texto'
                            : null,
                        onSaved: (input) => _texto = input,
                        initialValue: _texto,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      height: 60.0,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: FlatButton(
                        child: Text(
                          'Criar',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: _salvar,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _salvar() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _qrData = _texto;
      });
    }
  }


  Future<void> _captureAndSharePng() async {
    try {
      print('Entrei');
      RenderRepaintBoundary boundary =
      globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
     // ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      ByteData byteData = await QrPainter(data: _qrData, version: QrVersions.auto,color: Colors.blue)
          .toImageData(1000);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      await Share.file(_qrData, '${_qrData.trim()}.png', pngBytes, 'image/png');


      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'QR Code savo',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
            ),
            backgroundColor: Colors.green,
          ),
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }


  _qrCodeToImage()async {
    ByteData qrbytes = await QrPainter(data: _qrData, version: QrVersions.auto)
        .toImageData(1000);



  }
}
