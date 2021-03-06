import 'package:flutter/material.dart';

class WitheringUnloadingItem extends StatelessWidget {

  final String id;
  final int batchNumber;
  final int troughNumber;
  final int boxNumber;
  final DateTime date;
  final double lotWeight;
  final double witheringPercentage;

  const WitheringUnloadingItem({Key key, this.id, this.batchNumber, this.troughNumber, this.boxNumber, this.date, this.lotWeight, this.witheringPercentage}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      color: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          leading: CircleAvatar(child: Text(batchNumber.toString(), style: TextStyle(fontSize: 40.0, color: Colors.white),),
            radius: 50.0,
            backgroundColor: Colors.greenAccent.shade700,),
          title: Text('TroughNumber : ' + '$troughNumber', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),),
          subtitle: Text('Box Number : ' + '$boxNumber', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
          trailing: Column(
            children: [
              Text('Lot Weight : ' + '$lotWeight', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),),
              Text('Withering % : ' + '${witheringPercentage.toStringAsFixed(2)}' + ' %', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}
