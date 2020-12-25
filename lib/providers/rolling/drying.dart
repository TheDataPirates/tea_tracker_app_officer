import 'package:flutter/material.dart';

class Drying with ChangeNotifier {
  final String id;
  final int batchNumber;
  final dhoolNumber;
  final double drierInWeight;
  final double drierOutWeight;
  final DateTime time;
  final double outturn;

  Drying({
    @required this.id,
    @required this.batchNumber,
    @required this.dhoolNumber,
    @required this.drierInWeight,
    @required this.drierOutWeight,
    @required this.time,
    @required this.outturn,
  });
}
