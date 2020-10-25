import 'package:flutter/material.dart';

class Fermenting with ChangeNotifier {
  final String id;
  final int batchNumber;
  final int dhoolNumber;
  final double dhoolInWeight;
  final double dhoolOutWeight;
  final DateTime time;

  Fermenting({
    @required this.id,
    @required this.batchNumber,
    @required this.dhoolNumber,
    @required this.dhoolInWeight,
    @required this.dhoolOutWeight,
    @required this.time,
  });
}
