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
    final _height = MediaQuery.of(context).size.height;

    final _width = MediaQuery.of(context).size.width;
    return Container(
        padding:  EdgeInsets.all(_width * 0.01),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
            color: Colors.greenAccent.shade700,
            border: Border.all(color: const Color(0xff099857),)),
        child: Column(
          children: [
            Container(child: Text(name, style: TextStyle(fontSize: _height * 0.045, fontWeight: FontWeight.bold, color: Colors.white,),), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26),),),),
            Text('$variableName', style: TextStyle(fontSize: _height * 0.04, fontWeight: FontWeight.bold, color: Colors.white,),),
          ],
        ));
  }
}
