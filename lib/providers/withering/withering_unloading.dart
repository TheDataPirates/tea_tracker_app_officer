import 'package:flutter/material.dart';

class WitheringUnloading with ChangeNotifier {
  final String id;
  final int batchNumber;
  final int troughNumber;
  final int boxNumber;
  final DateTime date;
  final double lotWeight;
  final double witheringPct;

  WitheringUnloading({
    @required this.id,
    @required this.batchNumber,
    @required this.troughNumber,
    @required this.boxNumber,
    @required this.date,
    @required this.lotWeight,
    @required this.witheringPct,
  });
}
