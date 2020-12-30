class QrData {
  int id;
  String qrData;
  String comentario;
  DateTime data = DateTime.now();

  // Objeto
  QrData({this.qrData, this.comentario, this.data});

  // Objeto com ID
  QrData.withId({this.id, this.qrData, this.comentario, this.data});

  // Serializar o objeto
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id']       = id;
    }
    map['qrData']     = qrData;
    map['comentario'] = comentario;
    map['data']       = data.toIso8601String();
    return map;
  }

  // Deserializar o objeto
  factory QrData.fromMap(Map<String, dynamic> map) {
    return QrData.withId(
      id:                   map['id'],
      qrData:               map['qrData'],
      comentario:           map['comentario'],
      data:  DateTime.parse(map['data']),
    );
  }
}
