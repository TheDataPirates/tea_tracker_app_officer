import 'package:flutter/material.dart';

class BigBulk with ChangeNotifier {
  final String id;
  final int bigBulkNumber;
  final double bigBulkWeight;
  final DateTime time;

  BigBulk({
    @required this.id,
    @required this.bigBulkNumber,
    @required this.bigBulkWeight,
    @required this.time,
  });
}
