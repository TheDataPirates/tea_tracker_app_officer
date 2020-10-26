import 'package:flutter/cupertino.dart';

class Lot with ChangeNotifier {
  final String lotId;
  final String supplier_id;
  final String supplier_name;
  final String container_type;
  final int no_of_containers;
  final int gross_weight;
  final String leaf_grade;
  final int water;
  final int course_leaf;
  final int other;
  final int deductions; // calculated fields
  final int net_weight; //calculated fields

  Lot({
    this.lotId,
    this.supplier_id,
    this.supplier_name,
    this.container_type,
    this.no_of_containers,
    this.gross_weight,
    this.leaf_grade,
    this.water,
    this.course_leaf,
    this.other,
    this.deductions,
    this.net_weight,
  });
}
