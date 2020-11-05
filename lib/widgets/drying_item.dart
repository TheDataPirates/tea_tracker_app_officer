import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';

class DryingItem extends StatelessWidget {

  final String id;
  final int batchNumber;
  final dhoolNumber;
  final DateTime time;
  final double drierInWeight;
  final double drierOutWeight;

  const DryingItem({Key key, this.id, this.batchNumber, this.dhoolNumber, this.time, this.drierInWeight, this.drierOutWeight}) : super(key: key);

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
          title: Text('Dhool Number : ' + '$dhoolNumber' , style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
          subtitle: Text('Time : ' + '$timeNow', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          trailing: Column(children: [
            Text('Drier In Weight : ' + '$drierInWeight', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
            Text('Drier Out Weight : ' + '$drierOutWeight', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          ],),
        ),
      ),
    );
  }
}