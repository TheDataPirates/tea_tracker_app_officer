import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:teatrackerappofficer/widgets/withering_view_item.dart';

class WitheringStartingFinishingItem extends StatelessWidget {
  final String id;
  final int troughNumber;
  final DateTime time;
  final double temperature;
  final double humidity;

  const WitheringStartingFinishingItem(
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
    final _height = MediaQuery.of(context).size.height;

    final _width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 10,
      margin:  EdgeInsets.symmetric(
        horizontal: _height * 0.001,
        vertical: _width * 0.004,
      ),
      color: Colors.black54,
      child: Padding(
          padding:  EdgeInsets.all(_width * 0.004),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WitheringViewItem(
                variableName: troughNumber,
                name: 'Trough Number',
              ),
              WitheringViewItem(
                variableName: timeNow,
                name: 'Time',
              ),
              WitheringViewItem(
                variableName: temperature,
                name: 'Temperature',
              ),
              WitheringViewItem(
                variableName: humidity,
                name: 'Humidity',
              ),
            ],
          )),
    );
  }
}
