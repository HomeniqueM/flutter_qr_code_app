import 'package:flutter/material.dart';
import 'package:flutter_qr_code_app/src/models/qrdata_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_qr_code_app/src/helpers/database_helpers.dart';



class EditNote extends StatefulWidget {
  final QrData qrdata;
  final String qrCodeLoad;

  const EditNote({this.qrdata, this.qrCodeLoad});

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  // Definições
  final _formkey = GlobalKey<FormState>();
  String _qrdata;

  String _comentario;
  final DateFormat _dateFormatter =
      DateFormat('dd.MM.yyyy'); // Formatação de Datas

  // Inicio da aplicação
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.qrdata != null) {
      _qrdata = widget.qrdata.qrData;
      _comentario = widget.qrdata.comentario;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nota e observações'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete_outline_sharp,
              color: Colors.white,
              size: 40,
            ),
            onPressed: _delete,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: <Widget>[
              Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: TextFormField(
                        readOnly: true,
                        maxLines: 15,
                        style: TextStyle(fontSize: 18.0),
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelText: 'Qrcode lido',
                            labelStyle: TextStyle(fontSize: 18.0),
                            //  border: InputBorder.none,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide()),
                            fillColor: Colors.deepPurple),
                        initialValue: _qrdata,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: TextFormField(
                        maxLines: 5,
                        style: TextStyle(fontSize: 18.0),
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'Comentário',
                          labelStyle: TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (input) => input.trim().isEmpty
                            ? 'Por favor, entrer com um nome'
                            : null,
                        onSaved: (input) => _comentario = input,
                        initialValue: _comentario,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: FlatButton(
                        child: Text(
                          'Atualizar',
                          // widget.tarefa == null ? 'Adicionar' : 'Atualizar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: _submit,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _submit() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      QrData qrdata = QrData(qrData: _qrdata, comentario: _comentario);

      if (widget.qrdata == null) {
        DataBaseHelper.instance.insertqrData(qrdata);
      } else {
        qrdata.id = widget.qrdata.id;
        qrdata.data = widget.qrdata.data;
        DataBaseHelper.instance.updateQrData(qrdata);
      }
      Navigator.of(context).pop();
    }
  }

  _delete() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Excluir nota'),
        content: Text('Confirmar?'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Não',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            onPressed: () {
              DataBaseHelper.instance.deleteTarefa(widget.qrdata.id);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              'Sim',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
