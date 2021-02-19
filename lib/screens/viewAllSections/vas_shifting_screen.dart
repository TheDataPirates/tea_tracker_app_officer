import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/constants.dart';

class VasShiftingScreen extends StatefulWidget {
  @override
  _VasShiftingScreenState createState() => _VasShiftingScreenState();
}

class _VasShiftingScreenState extends State<VasShiftingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shifting View'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image : VASBackgroundImage,
//            gradient:kUIGradient
        ),
      ),
    );
  }
}
