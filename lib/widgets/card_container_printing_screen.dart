import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer(
      {Key key,
        @required double height,
        @required double width,
      @required this.lotData,
      @required this.labelText})
      : _height = height,
        _width = width,
        super(key: key);

  final lotData;
  final String labelText;
  final double _height;
  final double _width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.greenAccent.shade700,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Card(
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.greenAccent.shade700,
        // Theme.of(context).accentColor,
        child: Column(
//          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labelText,
              style: TextStyle(color: Colors.white, fontSize: _width * 0.02, fontWeight: FontWeight.bold),
              // Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              lotData != null ? '$lotData' : "Empty",
              style: TextStyle(color: Colors.white, fontSize: _width * 0.0275),
              // Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
