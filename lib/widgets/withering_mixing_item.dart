import 'package:flutter/material.dart';

class WitheringMixingItem extends StatelessWidget {

  final String id;
  final int troughNumber;
  final int turn;
  final DateTime time;
  final double temperature;
  final double humidity;

  const WitheringMixingItem({Key key, this.id, this.troughNumber, this.turn, this.time, this.temperature, this.humidity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 1,
        vertical: 4,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(child: Text(troughNumber.toString()),),
          title: Text('Turn : ' + '$turn' + '          ' + 'Time : ' + '$time'),
          subtitle: Text('Temperature : ' + '$temperature' + '          ' + 'Humidity : ' + '$humidity'),
        ),
      ),
    );
  }
}
