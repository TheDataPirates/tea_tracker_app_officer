import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/providers/rolling/fermenting.dart';
import 'package:teatrackerappofficer/providers/rolling/roll_breaking.dart';
import 'package:teatrackerappofficer/providers/rolling/rolling.dart';

class RollingProvider with ChangeNotifier {
  //----------------Rolling Input -------------------

  List<Rolling> _rollingInputItems = [];

  List<Rolling> get rollingInputItems {
    return [..._rollingInputItems];
  }

  int get rollingInputItemCount {
    return _rollingInputItems.length;
  }

  Rolling findById(String id) {
    return _rollingInputItems.firstWhere((rolling) => rolling.id == id);
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

  //----------------Rolling Output -------------------

  List<Rolling> _rollingOutputItems = [];

  List<Rolling> get rollingOutputItems {
    return [..._rollingOutputItems];
  }

  int get rollingOutputItemCount {
    return _rollingOutputItems.length;
  }

  Rolling findByIdOutput(String id) {
    return _rollingOutputItems.firstWhere((rolling) => rolling.id == id);
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

//----------------Roll Breaking -------------------

  List<RollBreaking> _rollBreakingItems = [];

  List<RollBreaking> get rollBreakingItems {
    return [..._rollBreakingItems];
  }

  int get rollBreakingItemCount {
    return _rollBreakingItems.length;
  }

  RollBreaking findByIdRollBreaking(String id) {
    return _rollBreakingItems.firstWhere((rollBreaking) => rollBreaking.id == id);
  }

  void addRollBreakingItem(RollBreaking rollBreaking) {
    final newRollBreakingItem = RollBreaking(
      id: DateTime.now().toString(),
      batchNumber: rollBreaking.batchNumber,
      rollBreakingTurn: rollBreaking.rollBreakingTurn,
      rollBreakerNumber: rollBreaking.rollBreakerNumber,
      weight: rollBreaking.weight,
      time: DateTime.now(),
    );

    _rollBreakingItems.add(rollBreaking);
    notifyListeners();
  }

  //----------------Fermenting -------------------

  List<Fermenting> _fermentingItems = [];

  List<Fermenting> get fermentingItems {
    return [..._fermentingItems];
  }

  int get fermentingItemCount {
    return _fermentingItems.length;
  }

  Fermenting findByIdFermenting(String id) {
    return _fermentingItems.firstWhere((ferment) => ferment.id == id);
  }

  void addFermentingItem(Fermenting fermenting) {
    final newFermentingItem = Fermenting(
      id: DateTime.now().toString(),
      batchNumber: fermenting.batchNumber,
      dhoolNumber: fermenting.dhoolNumber,
      dhoolInWeight: fermenting.dhoolInWeight,
      dhoolOutWeight: fermenting.dhoolOutWeight,
      time: DateTime.now(),
    );

    _fermentingItems.add(fermenting);
    notifyListeners();
  }

}
