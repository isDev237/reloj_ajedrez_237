
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Untils{

  Text textoTiempo(String tiempo){
    return Text(
      tiempo,
      style: TextStyle(
        fontFamily: "Arial",
        fontSize: 140.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Future<bool?> mensajeToast(String mensaje, bool play){
    return Fluttertoast.showToast(
        msg: mensaje,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: play ? Colors.green : Colors.red,
        textColor: Colors.white,
        fontSize: 30.0
      );
  }
}