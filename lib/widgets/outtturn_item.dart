import 'package:flutter/material.dart';

class OutturnItem extends StatelessWidget {
  final int batchNumber;
  final double outturn;

  const OutturnItem({Key key, this.batchNumber, this.outturn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      color: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          leading: const Text(
            'Batch Number : ',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white,),
          ),
          title: CircleAvatar(
            child: Text(batchNumber.toString(),
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                )),
            radius: 50.0,
            backgroundColor: Colors.greenAccent.shade700,
          ),
          trailing: Chip(
            label: Text(
              '${outturn.toStringAsFixed(4)}' + ' %',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            backgroundColor: Colors.greenAccent.shade700,
          ),
        ),
      ),
    );
  }
}
