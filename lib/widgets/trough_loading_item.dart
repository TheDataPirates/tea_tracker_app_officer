import 'package:flutter/material.dart';

class TroughLoadingItem extends StatelessWidget {

  final String id;
  final int troughNumber;
  final int boxNumber;
  final String gradeGL;
  final double netWeight;
  final double recentWeight;

  TroughLoadingItem({this.id, this.troughNumber, this.boxNumber, this.gradeGL, this.netWeight, this.recentWeight});

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
            leading: CircleAvatar(child: Text(gradeGL, style: TextStyle(fontSize: 40.0, color: Colors.white),),
              radius: 50.0,
              backgroundColor: Colors.greenAccent.shade700,),
            title: Text('Trough Number : ' + '$troughNumber', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),),
            subtitle: Text('Box Number : ' + '$boxNumber', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
            trailing: Column(
              children: [
                Text('Recently added : ' +'$recentWeight' + ' Kg', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
                SizedBox(height: 6,),
                Text('Total Box Weight : ' +'$netWeight' + ' Kg', style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold, color: Colors.white),),
              ],
            )
        ),
      ),
    );
  }
}