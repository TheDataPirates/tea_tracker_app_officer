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
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 10.0,
      margin:  EdgeInsets.symmetric(
        horizontal: _height * 0.001,
        vertical: _width * 0.004,
      ),
      color: Colors.black54,
      child: Padding(
        padding:  EdgeInsets.all(_width * 0.004),
        child: ListTile(
          leading: CircleAvatar(child: Text(batchNumber.toString(), style: TextStyle(fontSize: _width * 0.045, color: Colors.white),),
            radius: _width * 0.045,
            backgroundColor: Colors.greenAccent.shade700,),
          title: Text('TroughNumber : ' + '$troughNumber', style: TextStyle(fontSize: _width * 0.025, fontWeight: FontWeight.bold, color: Colors.white),),
          subtitle: Text('Box Number : ' + '$boxNumber', style: TextStyle(fontSize: _width * 0.025, fontWeight: FontWeight.bold, color: Colors.white),),
          trailing: Column(
            children: [
              Text('Lot Weight : ' + '$lotWeight', style: TextStyle(fontSize: _width * 0.025, fontWeight: FontWeight.bold, color: Colors.white),),
              Text('Withering % : ' + '${witheringPercentage.toStringAsFixed(2)}' + ' %', style: TextStyle(fontSize: _width * 0.025, fontWeight: FontWeight.bold, color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}
