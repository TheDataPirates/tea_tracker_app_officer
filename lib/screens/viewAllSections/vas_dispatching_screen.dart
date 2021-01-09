import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/constants.dart';

class VasDispatchingScreen extends StatefulWidget {
  @override
  _VasDispatchingScreenState createState() => _VasDispatchingScreenState();
}

class _VasDispatchingScreenState extends State<VasDispatchingScreen> {
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
