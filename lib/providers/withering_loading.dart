import 'package:flutter/cupertino.dart';

class WitheringLoading with ChangeNotifier {
  final String id;
  final int troughNumber;
  final int boxNumber;
  final String gradeOfGL;
  final double netWeight;
  final DateTime date;

  WitheringLoading({
    @required this.id,
    @required this.troughNumber,
    @required this.boxNumber,
    @required this.gradeOfGL,
    @required this.netWeight,
    @required this.date,
  });
}
