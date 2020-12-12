import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';

class RollBreakingItem extends StatelessWidget {

  final String id;
  final int batchNumber;
  final int rollBreakingTurn;
  final DateTime time;
  final int rollBreakerNumber;
  final double weight;

  const RollBreakingItem({Key key, this.id, this.batchNumber, this.rollBreakingTurn, this.time, this.rollBreakerNumber, this.weight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var timeNow = time.format('H:i,  d/m/Y');

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      color: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          leading: CircleAvatar(child: Text(batchNumber.toString(), style: TextStyle(fontSize: 40.0, color: Colors.white)),
            radius: 50.0,
            backgroundColor: Colors.greenAccent.shade700,),
          title: Text('Roll Breaking Turn : ' + '$rollBreakingTurn' , style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),),
          subtitle: Text('Roll Breaker Number : ' + '$rollBreakerNumber', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
          trailing: Column(children: [
            Text('Time : ' + '$timeNow', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
            Text('Dhool Weight : ' + '$weight', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
          ],),
        ),
      ),
    );
  }
}
