import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/constants.dart';

class VasDispatchingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispatching View'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient:kUIGradient
        ),
      ),
    );
  }
}
