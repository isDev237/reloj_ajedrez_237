
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class InicioPage extends StatefulWidget {

  const InicioPage(
      {Key? key}) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> with SingleTickerProviderStateMixin{

  double _accelX = 0.0;
  String _orientation = 'Horizontal';

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelX = event.x;
        _orientation = _getOrientation(event.x);
      });
    });
  }
  String _getOrientation(double accelX) {
    if (accelX > 1) {
      return 'Inclinado a la izquierda';
    } else if (accelX < -1) {
      return 'Inclinado a la derecha';
    } else {
      return 'Horizontal';
    }
  }
  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Text("informacion de una page",
          style: TextStyle(
            color: Color(0xFF000000)
          ),),

          Text(
            'Aceleración en X: $_accelX',
          ),
          Text(
            'Orientación: $_orientation',
          ),

        ],
      )
    );
  }
}