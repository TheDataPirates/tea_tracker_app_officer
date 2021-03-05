import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/constants.dart';

class ShiftingRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shifting Room'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image : inputScreenBackgroundImage,
            gradient: kUIGradient,
        ),
      ),
    );
  }
}
