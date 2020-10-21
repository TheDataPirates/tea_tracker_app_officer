import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:teatrackerappofficer/widgets/withering_view_item.dart';

class WitheringStartingItem extends StatelessWidget {
  final String id;
  final int troughNumber;
  final DateTime time;
  final double temperature;
  final double humidity;

  const WitheringStartingItem(
      {Key key,
      this.id,
      this.troughNumber,
      this.time,
      this.temperature,
      this.humidity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    var timeNow = time.format('d/m/Y, H:i');

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 1,
        vertical: 4,
      ),
      child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WitheringViewItem(variableName: troughNumber, name: 'Trough Number',),
              WitheringViewItem(variableName: timeNow, name: 'Time',),
              WitheringViewItem(variableName: temperature, name: 'Temperature',),
              WitheringViewItem(variableName: humidity, name: 'Humidity',),
            ],
          )),
    );
  }
}

