import 'package:flutter/cupertino.dart';

class TroughLoading with ChangeNotifier {
  final String id;
  final int troughNumber;
  final int boxNumber;
  final String gradeOfGL;
  final double netWeight;

  TroughLoading({
    @required this.id,
    @required this.troughNumber,
    @required this.boxNumber,
    @required this.gradeOfGL,
    @required this.netWeight,
  });
}
