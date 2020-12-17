import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/constants.dart';

class DispatchingRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispatching Room'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient:kUIGradient,
        ),
      ),
    );
  }
}
