import 'package:flutter/material.dart';

class WitheringMixing with ChangeNotifier {
  final String id;
  final int troughNumber;
  final int turn;
  final DateTime time;
  final double temperature;
  final double humidity;

  WitheringMixing({
    @required this.id,
    @required this.troughNumber,
    @required this.turn,
    @required this.time,
    @required this.temperature,
    @required this.humidity,
  });
}
