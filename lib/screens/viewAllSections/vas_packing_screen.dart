import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/constants.dart';

class VasPackingScreen extends StatefulWidget {
  @override
  _VasPackingScreenState createState() => _VasPackingScreenState();
}

class _VasPackingScreenState extends State<VasPackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Packing View'),
    ),
      body: Container(
        decoration: BoxDecoration(
            gradient:kUIGradient
        ),
      ),
    );
  }
}
