import 'package:flutter/material.dart';

class DifferenceReport with ChangeNotifier {
  final String reportId;
  final double originalWeight;
  final double remeasuringWeight;
  final double weightDifference;
  final String supplierId;

  DifferenceReport({
    @required this.reportId,
    @required this.originalWeight,
    @required this.remeasuringWeight,
    @required this.weightDifference,
    @required this.supplierId,
  });
}
