import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';

class RollingItem extends StatelessWidget {
  final String id;
  final int batchNumber;
  final rollingTurn;
  final DateTime time;
  final int rollerNumber;
  final double weightIn;
  final double weightOut;
  final double _height;
  final double _width;

  const RollingItem({
    Key key,
    @required double height,
    @required double width,
    this.id,
    this.batchNumber,
    this.rollingTurn,
    this.time,
    this.rollerNumber,
    this.weightIn,
    this.weightOut,
  }) : _height = height,
        _width = width,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var timeNow = time.format('H:i,  d/m/Y');
//    final _height = MediaQuery.of(context).size.height;
//    final _width = MediaQuery.of(context).size.width;
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: _width * 0.01,
        vertical: _height * 0.01,
      ),
      color: Colors.black54,
      child: Padding(
        padding: EdgeInsets.all(_width * 0.005),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(batchNumber.toString(),
                style:
                    TextStyle(fontSize: _width * 0.045, color: Colors.white)),
            radius: _width * 0.045,
            backgroundColor: Colors.greenAccent.shade700,
          ),
          title: Text(
            'Rolling Turn : ' +
                '$rollingTurn' +
                '          ' +
                'Roller Number : ' +
                '$rollerNumber',
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
                'Weight In : ' + '$weightIn',
                style: TextStyle(
                    fontSize: _width * 0.025,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'Weight Out : ' + '$weightOut',
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
