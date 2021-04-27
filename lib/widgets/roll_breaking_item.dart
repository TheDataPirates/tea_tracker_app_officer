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
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Card(
      margin:  EdgeInsets.symmetric(
        horizontal: _width * 0.01,
        vertical: _height * 0.01,
      ),
      color: Colors.black54,
      child: Padding(
        padding:  EdgeInsets.all(_width * 0.005),
        child: ListTile(
          leading: CircleAvatar(child: Text(batchNumber.toString(), style: TextStyle(fontSize: _width * 0.045, color: Colors.white)),
            radius: _width * 0.045,
            backgroundColor: Colors.greenAccent.shade700,),
          title: Text('Roll Breaking Turn : ' + '$rollBreakingTurn' , style: TextStyle(fontSize: _width * 0.025, fontWeight: FontWeight.bold, color: Colors.white),),
          subtitle: Text('Roll Breaker Number : ' + '$rollBreakerNumber', style: TextStyle(fontSize: _width * 0.025, fontWeight: FontWeight.bold, color: Colors.white),),
          trailing: Column(children: [
            Text('Time : ' + '$timeNow', style: TextStyle(fontSize: _width * 0.025, fontWeight: FontWeight.bold, color: Colors.white),),
            Text('Dhool Weight : ' + '$weight', style: TextStyle(fontSize: _width * 0.025, fontWeight: FontWeight.bold, color: Colors.white),),
          ],),
        ),
      ),
    );
  }
}
