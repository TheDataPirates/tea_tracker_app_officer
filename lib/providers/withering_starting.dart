import 'package:flutter/material.dart';

class WitheringStarting with ChangeNotifier {
  final String id;
  final int troughNumber;
  final DateTime time;
  final double temperature;
  final double humidity;

  WitheringStarting({
    @required this.id,
    @required this.troughNumber,
    @required this.time,
    @required this.temperature,
    @required this.humidity,
  });
}
