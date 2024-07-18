import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reloj_ajedrez_inclinado/Untils.dart';
import 'package:sensors_plus/sensors_plus.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> with SingleTickerProviderStateMixin {
  double _accelY = 0.0;
  String inclinacion = "";

  late Timer _timer;
  int _whiteTime = 300; // 5 minutos = 300 segundos
  int _blackTime = 300;
  bool _isWhiteTurn = true;
  bool play = false;


  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 1100), (timer) {
      setState(() {
        if (_isWhiteTurn) {
          if (_whiteTime > 0 && play) _whiteTime--;
        } else {
          if (_blackTime > 0 && play) _blackTime--;
        }
      });
    });
  }

  void _stopTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  void _switchTurn() {
    setState(() {
      _isWhiteTurn = !_isWhiteTurn;
    });
  }

  @override
  void initState() {
    super.initState();

    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelY = event.y;
        _handleAccelerometerChange();
      });
    });

  }

  void _handleAccelerometerChange() {

    if (_accelY < 0.9 && _accelY > 0 ) {
      inclinacion = "Centro";

    } else if (_accelY >= 1 && play) {
      inclinacion = "Derecha";

      if(!_isWhiteTurn) { _switchTurn(); }


    } else if (_accelY <= -1 && play) {
      inclinacion = "Izquierda";

      if(_isWhiteTurn) { _switchTurn(); }

    }


  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //interfaz

            Row(
              children: [

                SizedBox(width: 35,),
                Container(
                  child: Untils().textoTiempo(_formatTime(_whiteTime)),
                ),
                InkWell(
                  onLongPress: (){

                    Untils().mensajeToast("El tiempo se ha reiniciado", false);

                    setState(() {
                      _timer.cancel();
                      _whiteTime = 300;
                      _blackTime = 300;
                      play = false;


                    });
                  },
                  onTap: (){

                    String msg_toast = "";

                    setState(() {
                      play = !play;
                      print(play);



                      if(play){
                        msg_toast = "PLAY";
                        _startTimer();

                      } else {
                        msg_toast = "PAUSE";
                        _stopTimer();

                      }
                    });

                    Untils().mensajeToast(msg_toast, play);

                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    child: Icon(
                      play ? Icons.pause_circle_outline : Icons.play_circle_outline,
                      size: 60,
                    ),
                  ),
                ),
                Container(
                  child: Untils().textoTiempo(_formatTime(_blackTime)),
                ),
              ],
            ),

            Text('Inclinación: ${inclinacion}'),




            //este cronometro funciona
            /*
            Text('Acelerómetro Y: $_accelY'),
            SizedBox(height: 20),
            Text('Inclinación: ${inclinacion}'),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Blanco: ${_formatTime(_whiteTime)}',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                Text(
                  'Negro: ${_formatTime(_blackTime)}',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _isWhiteTurn ? _switchTurn : null,
                      child: Text('Blanco Hecho'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: !_isWhiteTurn ? _switchTurn : null,
                      child: Text('Negro Hecho'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _startTimer,
                  child: Text('Iniciar Reloj'),
                ),
              ],
            ),
            */

          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

}
