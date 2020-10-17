
import 'package:flutter/material.dart';

class MainMenuFlatButtonContainer extends StatelessWidget {
  const MainMenuFlatButtonContainer({
    Key key,
    @required double height,
    @required double width,
    @required this.name,
    @required this.destination,
  }) : _height = height, _width = width, super(key: key);

  final double _height;
  final double _width;
  final String name;
  final String destination;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
          color: Colors.green,
          onPressed: () {
            Navigator.of(context).pushNamed(destination);
          },
          child: Text(this.name,style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25.0
          ),),
          height: _height * 0.2,
          minWidth: _width * 0.3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.greenAccent))),
    );
  }
}
