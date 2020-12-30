import 'dart:io';

import 'package:flutter_qr_code_app/src/models/qrdata_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static final DataBaseHelper instance = DataBaseHelper._instance();
  static Database _db;

  DataBaseHelper._instance();

  String tabeleqrDataNotes = 'tabela_qr_code';
  String colId = 'id';
  String colQrData = 'qrData';
  String colComentario = 'comentario';
  String colData = 'data';

  Future<Database> get db async {
    if (_db == null) {
      _db = await _iniciarBancoDeDados();
    }
    return _db;
  }

  Future<Database> _iniciarBancoDeDados() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + '${tabeleqrDataNotes}.db';
    final qrDataListDb =
        await openDatabase(path, version: 1, onCreate: _criarDancobeDados);
    return qrDataListDb;
  }

  void _criarDancobeDados(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tabeleqrDataNotes($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colQrData TEXT, $colComentario TEXT, $colData TEXT)');
  }

  // Retorna toda a tabela em List Map
  Future<List<Map<String, dynamic>>> getTabelaMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(tabeleqrDataNotes);
    return result;
  }

  // Converte o list de maps do banco de dados em uma lista de objetos Tarefa
  Future<List<QrData>> getQrDatafaList() async {
    final List<Map<String, dynamic>> qrdataMapLis = await getTabelaMapList();
    final List<QrData> qrDataList = [];

    qrdataMapLis.forEach((qrDatafaMap) {
      qrDataList.add(QrData.fromMap(qrDatafaMap));
    });
    qrDataList.sort((dataA, dataB) => dataA.data.compareTo(dataB.data));
    return qrDataList;
  }

  // inserir nota dentro do banco de dados
  Future<int> insertqrData(QrData data) async {
    Database db = await this.db;
    final int result = await db.insert(tabeleqrDataNotes, data.toMap());
    return result;
  }

  //Atualiza uma Nota dentro de obanco de dados
  Future<int> updateQrData(QrData data) async {
    Database db = await this.db;
    final int result = await db.update(tabeleqrDataNotes, data.toMap(),
        where: '$colId = ?', whereArgs: [data.id]);
    return result;
  }

  //Deleta apatir de uma ID
  Future<int> deleteTarefa(int id) async {
    Database db = await this.db;
    final int result = await db.delete(
      tabeleqrDataNotes,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }
}
