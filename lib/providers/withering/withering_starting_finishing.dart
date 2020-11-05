import 'package:flutter/material.dart';

class WitheringStartingFinishing with ChangeNotifier {
  final String id;
  final int troughNumber;
  final DateTime time;
  final double temperature;
  final double humidity;

  WitheringStartingFinishing({
    this.id,
    this.troughNumber,
    this.time,
    this.temperature,
    this.humidity,
  });
}
