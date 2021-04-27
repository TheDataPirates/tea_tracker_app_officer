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
          leading: CircleAvatar(child: Text(batchNumber.toString(), style: TextStyle(fontSize: _width * 0.045, color: Colors.white),),radius: _width * 0.045, backgroundColor: Colors.greenAccent.shade700,),
          title: Text('Dhool Number : ' + '$dhoolNumber' , style: TextStyle(fontSize: _width * 0.025, fontWeight: FontWeight.bold, color: Colors.white),),
          subtitle: Text('Time : ' + '$timeNow', style: TextStyle(fontSize: _width * 0.025, fontWeight: FontWeight.bold, color: Colors.white),),
          trailing: Column(children: [
            Text('Drier In Weight : ' + '$drierInWeight', style: TextStyle(fontSize: _width * 0.025, fontWeight: FontWeight.bold, color: Colors.white),),
            Text('Drier Out Weight : ' + '$drierOutWeight', style: TextStyle(fontSize: _width * 0.025, fontWeight: FontWeight.bold, color: Colors.white),),
          ],),
        ),
      ),
    );
  }
}
