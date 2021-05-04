import 'package:flutter/material.dart';

class OutturnItem extends StatelessWidget {
  final int batchNumber;
  final double outturn;
  final double _height;
  final double _width;

  const OutturnItem(
      {Key key,
      @required double height,
      @required double width,
      this.batchNumber,
      this.outturn})
      : _height = height,
        _width = width,
        super(key: key);

  @override
  Widget build(BuildContext context) {
//    final _height = MediaQuery.of(context).size.height;
//    final _width = MediaQuery.of(context).size.width;
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: _height * 0.001,
        vertical: _width * 0.004,
      ),
      color: Colors.black54,
      child: Padding(
        padding: EdgeInsets.all(_width * 0.004),
        child: ListTile(
          leading: Text(
            'Batch Number : ',
            style: TextStyle(
              fontSize: _width * 0.035,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          title: CircleAvatar(
            child: Text(batchNumber.toString(),
                style: TextStyle(
                  fontSize: _width * 0.05,
                  color: Colors.white,
                )),
            radius: _width * 0.05,
            backgroundColor: Colors.greenAccent.shade700,
          ),
          trailing: Chip(
            label: Text(
              '${outturn.toStringAsFixed(4)}' + ' %',
              style: TextStyle(fontSize: _width * 0.025, color: Colors.white),
            ),
            backgroundColor: Colors.greenAccent.shade700,
          ),
        ),
      ),
    );
  }
}
