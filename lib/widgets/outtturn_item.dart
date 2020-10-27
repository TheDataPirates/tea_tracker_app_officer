import 'package:flutter/material.dart';

class OutturnItem extends StatelessWidget {
  final int batchNumber;
  final double outturn;

  const OutturnItem({Key key, this.batchNumber, this.outturn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
          leading: Text(
            'Batch Number : ',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          title: CircleAvatar(
            child: Text(batchNumber.toString(),
                style: TextStyle(
                  fontSize: 40.0,
                )),
            radius: 50.0,
          ),
          trailing: Chip(
            label: Text(
              '$outturn' + ' %',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
