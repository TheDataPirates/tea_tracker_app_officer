import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';

class WitheringMixingItem extends StatelessWidget {
  final String id;
  final int troughNumber;
  final int turn;
  final DateTime time;
  final double temperature;
  final double humidity;
  final double _height;
  final double _width;

  const WitheringMixingItem(
      {Key key,
        @required double height,
        @required double width,
      this.id,
      this.troughNumber,
      this.turn,
      this.time,
      this.temperature,
      this.humidity})
      : _height = height,
        _width = width,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var timeNow = time.format('H:i,  d/m/Y');
//    final _height = MediaQuery.of(context).size.height;
//
//    final _width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.symmetric(
        horizontal: _height * 0.001,
        vertical: _width * 0.004,
      ),
      color: Colors.black54,
      child: Padding(
        padding: EdgeInsets.all(_width * 0.004),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              troughNumber.toString(),
              style: TextStyle(fontSize: _width * 0.045, color: Colors.white),
            ),
            radius: _width * 0.045,
            backgroundColor: Colors.greenAccent.shade700,
          ),
          title: Text(
            'Turn : ' + '$turn',
            style: TextStyle(
                fontSize: _width * 0.025,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          subtitle: Text(
            'Time : ' + '$timeNow',
            style: TextStyle(
                fontSize: _width * 0.025,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          trailing: Column(
            children: [
              Text(
                'Temperature : ' + '$temperature',
                style: TextStyle(
                    fontSize: _width * 0.025,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'Humidity : ' + '$humidity',
                style: TextStyle(
                    fontSize: _width * 0.025,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
