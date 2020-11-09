import 'package:flutter/material.dart';

class EndedLoadingTroughBox with ChangeNotifier {
  final String id;
  final int troughNumber;
  final int boxNumber;
  final DateTime date;

  EndedLoadingTroughBox({
    @required this.id,
    @required this.troughNumber,
    @required this.boxNumber,
    @required this.date,
  });
}
