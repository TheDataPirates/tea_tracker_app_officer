import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';

class RollingItem extends StatelessWidget {

  final String id;
  final int batchNumber;
  final int rollingTurn;
  final DateTime time;
  final int rollerNumber;
  final double weight;

  const RollingItem({Key key, this.id, this.batchNumber, this.rollingTurn, this.time, this.rollerNumber, this.weight}) : super(key: key);

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
          leading: CircleAvatar(child: Text(batchNumber.toString(), style: TextStyle(fontSize: 40.0,)),radius: 50.0,),
          title: Text('Rolling Turn : ' + '$rollingTurn' , style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
          subtitle: Text('Roller Number : ' + '$rollerNumber', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          trailing: Column(children: [
            Text('Time : ' + '$timeNow', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
            Text('Weight : ' + '$weight', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          ],),
        ),
      ),
    );
  }
}
