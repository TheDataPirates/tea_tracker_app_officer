import 'package:flutter/material.dart';

class RollBreaking with ChangeNotifier {
  final String id;
  final int batchNumber;
  final int rollBreakingTurn;
  final int rollBreakerNumber;
  final double weight;
  final DateTime time;

  RollBreaking({
    @required this.id,
    @required this.batchNumber,
    @required this.rollBreakingTurn,
    @required this.rollBreakerNumber,
    @required this.weight,
    @required this.time,
  });
}
