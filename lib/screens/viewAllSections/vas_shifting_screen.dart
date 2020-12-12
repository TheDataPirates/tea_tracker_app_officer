import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/constants.dart';

class VasShiftingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shifting View'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient:kUIGradient
        ),
      ),
    );
  }
}
