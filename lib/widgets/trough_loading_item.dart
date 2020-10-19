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
      margin: EdgeInsets.symmetric(
        horizontal: 1,
        vertical: 4,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(child: Text(gradeGL),),
          title: Text('Trough Number : ' + '$troughNumber'),
          subtitle: Text('Box Number : ' + '$boxNumber'),
          trailing: Text('$netWeight' + ' Kg'),
        ),
      ),
    );
  }
}
