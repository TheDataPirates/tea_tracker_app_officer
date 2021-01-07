import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';

class DifferenceReportItem extends StatelessWidget {

  final String reportId;
  final double originalWeight;
  final double remeasuringWeight;
  final double weightDifference;

  const DifferenceReportItem({Key key, this.reportId, this.originalWeight, this.remeasuringWeight, this.weightDifference}) : super(key: key);


  @override
  Widget build(BuildContext context) {
//    var timeNow = time.format('H:i,  d/m/Y');

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      color: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          leading: CircleAvatar(child: Text(reportId.toString(), style: TextStyle(fontSize: 40.0, color: Colors.white),),radius: 50.0, backgroundColor: Colors.greenAccent.shade700,),
          title: Text('Original Weight : ' + '$originalWeight' , style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),),
          subtitle: Text('Reameasuring Weight : ' + '$remeasuringWeight', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
          trailing: Column(children: [
            Text('Weight Difference : ' + '$weightDifference', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
          ],),
        ),
      ),
    );
  }
}
