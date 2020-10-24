import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/providers/rolling/rolling.dart';

class RollingProvider with ChangeNotifier{
  List<Rolling> _rollingInputItems = [];

  List<Rolling> get rollingInputItems {
    return [..._rollingInputItems];
  }

  int get rollingInputItemCount{
    return _rollingInputItems.length;
  }

  Rolling findById(String id){
    return _rollingInputItems.firstWhere((rolling) => rolling.id ==  id);
  }

  void addRollingInputItem(Rolling rolling) {
    final newRollingInputItem = Rolling(
        id: DateTime.now().toString(),
        batchNumber: rolling.batchNumber,
        rollingTurn: rolling.rollingTurn,
        rollerNumber: rolling.rollerNumber,
        weight: rolling.weight,
        time: DateTime.now(),
    );

    _rollingInputItems.add(rolling);
    notifyListeners();
  }

  List<Rolling> _rollingOutputItems = [];

  List<Rolling> get rollingOutputItems {
    return [..._rollingOutputItems];
  }

  int get rollingOutputItemCount{
    return _rollingOutputItems.length;
  }

  Rolling findByIdOutput(String id){
    return _rollingOutputItems.firstWhere((rolling) => rolling.id ==  id);
  }

  void addRollingOutputItem(Rolling rolling) {
    final newRollingOutputItem = Rolling(
      id: DateTime.now().toString(),
      batchNumber: rolling.batchNumber,
      rollingTurn: rolling.rollingTurn,
      rollerNumber: rolling.rollerNumber,
      weight: rolling.weight,
      time: DateTime.now(),
    );

    _rollingOutputItems.add(rolling);
    notifyListeners();
  }
}