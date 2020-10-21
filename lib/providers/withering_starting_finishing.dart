import 'package:flutter/material.dart';

class WitheringStartingFinishing with ChangeNotifier {
  final String id;
  final int troughNumber;
  final DateTime time;
  final double temperature;
  final double humidity;

  WitheringStartingFinishing({
    @required this.id,
    @required this.troughNumber,
    @required this.time,
    @required this.temperature,
    @required this.humidity,
  });
}
