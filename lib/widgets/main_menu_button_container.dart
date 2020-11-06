import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class MainMenuFlatButtonContainer extends StatelessWidget {
  const MainMenuFlatButtonContainer({
    Key key,
    @required double height,
    @required double width,
    @required this.name,
    @required this.destination,
    @required this.iconString,
  })  : _height = height,
        _width = width,
        super(key: key);

  final double _height;
  final double _width;
  final String name;
  final String destination;
  final String iconString;



  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonTheme(
        height: _height * 0.2,
        minWidth: _width * 0.3,
        child: RaisedButton(
          elevation: 30.0,
          color: Colors.black.withOpacity(0.5),
          onPressed: () {
            Navigator.of(context).pushNamed(destination);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                this.name,
                style: GoogleFonts.courgette(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
                  ),
                ),
              ),
              IconButton(icon: FaIcon(FontAwesomeIcons.leaf, color: Colors.greenAccent, size: 50.0,), onPressed: (){},),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.greenAccent, width: 4.0),
          ),
        ),
      ),
    );
  }
}
