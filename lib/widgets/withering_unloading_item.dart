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
      margin: EdgeInsets.symmetric(
        horizontal: 1,
        vertical: 4,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(child: Text(batchNumber.toString()),),
          title: Text('TroughNumber : ' + '$troughNumber'),
          subtitle: Text('Box Number : ' + '$boxNumber'),
          trailing: Column(
            children: [
              Text('Lot Weight : ' + '$lotWeight'),
              Text('Withering % : ' + '$witheringPercentage' + ' %'),
            ],
          ),
        ),
      ),
    );
  }
}
