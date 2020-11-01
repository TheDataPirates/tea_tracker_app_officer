import 'package:flutter/material.dart';

class TroughLoadingItem extends StatelessWidget {

  final String id;
  final int troughNumber;
  final int boxNumber;
  final String gradeGL;
  final double netWeight;

  TroughLoadingItem({this.id, this.troughNumber, this.boxNumber, this.gradeGL, this.netWeight});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          leading: CircleAvatar(child: Text(gradeGL, style: TextStyle(fontSize: 40.0),),radius: 50.0,),
          title: Text('Trough Number : ' + '$troughNumber', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
          subtitle: Text('Box Number : ' + '$boxNumber', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          trailing: Text('$netWeight' + ' Kg', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
