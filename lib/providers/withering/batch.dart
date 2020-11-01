import 'package:flutter/material.dart';

class Batch with ChangeNotifier {
  final String id;
  final int batchNumber;
  final double batchWeight;
  final DateTime time;

  Batch({
    @required this.id,
    @required this.batchNumber,
    @required this.batchWeight,
    @required this.time,
  });
}
