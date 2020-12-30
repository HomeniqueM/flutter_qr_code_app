import 'package:flutter/material.dart';
import 'package:flutter_qr_code_app/src/screens/addAndEditScrees/create_screen.dart';
import 'package:flutter_qr_code_app/src/screens/addAndEditScrees/scan_scren.dart';


class AddEditScreen extends StatefulWidget {
  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /** "Designed by Freepik"
             * <a href="http://www.freepik.com">Designed by Freepik</a>
             */
            Image.asset("assets/images/qr_code_image.png"),
            flatButon(
              "Ler Qr code",
              Scan(),
            ),SizedBox(height: 50.0,),
            flatButon("Criar QR Code", Create())
          ],
        ),
      ),
    );
  }

  Widget flatButon(String text, Widget widget) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: FlatButton(
        color: Colors.deepPurple,
        padding: EdgeInsets.all(15.0),
        child: Text(text,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
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
