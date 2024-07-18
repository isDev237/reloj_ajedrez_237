
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
  //double _accelX = 0.0;
  double _accelY = 0.0;
  //double _accelZ = 0.0;
  //String _orientation = 'Horizontal';

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        //_accelX = event.x;
        _accelY = event.y;
        //_accelZ = event.z;
        //_orientation = _getOrientation(event.x, event.y, event.z);
      });
    });
  }

  String _getOrientation(double x, double y, double z) {
    if (y.abs() < 1 && x.abs() > 1) {
      if (x > 0) {
        return 'Inclinado a la izquierda';
      } else {
        return 'Inclinado a la derecha';
      }
    } else {
      return 'Horizontal';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detección de Inclinación'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Text('Acelerómetro X: $_accelX'),
            Text('Acelerómetro Y: $_accelY'),
            //Text('Acelerómetro Z: $_accelZ'),
            //Text('Orientación: $_orientation'),
          ],
        ),
      ),
    );
  }
}