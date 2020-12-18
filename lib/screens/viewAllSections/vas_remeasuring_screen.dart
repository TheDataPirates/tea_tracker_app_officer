import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/constants.dart';

class VasRemeasuringScreen extends StatefulWidget {
  @override
  _VasRemeasuringScreenState createState() => _VasRemeasuringScreenState();
}

class _VasRemeasuringScreenState extends State<VasRemeasuringScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remeasuring View'),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: kUIGradient),
      ),
    );
  }
}
