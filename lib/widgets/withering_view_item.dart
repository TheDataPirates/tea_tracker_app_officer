import 'package:flutter/material.dart';

class WitheringViewItem extends StatelessWidget {
  const WitheringViewItem({
    Key key,
    @required this.variableName,
    @required this.name,
  }) : super(key: key);

  final variableName;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
            color: Colors.greenAccent.shade700,
            border: Border.all(color: const Color(0xff099857),)),
        child: Column(
          children: [
            Container(child: Text(name, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white,),), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26),),),),
            Text('$variableName', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white,),),
          ],
        ));
  }
}
