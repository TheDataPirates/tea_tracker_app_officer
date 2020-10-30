import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';

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

    var timeNow = time.format('H:i,  d/m/Y');

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          leading: CircleAvatar(child: Text(troughNumber.toString(), style: TextStyle(fontSize: 40.0,)),radius: 50.0,),
          title: Text('Turn : ' + '$turn' , style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
          subtitle: Text('Time : ' + '$timeNow', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          trailing: Column(children: [
            Text('Temperature : ' + '$temperature', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
            Text('Humidity : ' + '$humidity', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          ],),
        ),
      ),
    );
  }
}
