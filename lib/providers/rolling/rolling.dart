import 'package:flutter/material.dart';

class Rolling with ChangeNotifier {
  final String id;
  final int batchNumber;
  final int rollingTurn;
  final int rollerNumber;
  final double weight;
  final DateTime time;

  Rolling({
    @required this.id,
    @required this.batchNumber,
    @required this.rollingTurn,
    @required this.rollerNumber,
    @required this.weight,
    @required this.time,
  });
}
