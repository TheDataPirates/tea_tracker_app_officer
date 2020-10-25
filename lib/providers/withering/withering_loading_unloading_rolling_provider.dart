import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/providers/rolling/fermenting.dart';
import 'package:teatrackerappofficer/providers/rolling/roll_breaking.dart';
import 'package:teatrackerappofficer/providers/rolling/rolling.dart';
import 'package:teatrackerappofficer/providers/withering/batch.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading.dart';
import 'package:teatrackerappofficer/providers/withering/withering_unloading.dart';



class WitheringLoadingUnloadingRollingProvider with ChangeNotifier {
  List<WitheringUnloading> _witheringUnloadingItems = [];

  List<int> _batchNumberItems = [];

  List<Batch> _batchItems = [];

  void addBatchItem(Batch batch) {
    final newBatchItem = Batch(
      id: DateTime.now().toString(),
      batchNumber: batch.batchNumber,
      batchWeight: batch.batchWeight,
      time: DateTime.now(),
    );

    _batchItems.add(batch);
    notifyListeners();
  }

  double batchWeight (int batchNo, DateTime dateTime, int rollingTurn){
    double bWeight;
    _batchItems.forEach((batchItem) {
      if ((batchItem.time.year == dateTime.year) &&
          (batchItem.time.month == dateTime.month) &&
          (batchItem.time.day == dateTime.day)){
        if(batchItem.batchNumber == batchNo){
          if(rollingTurn == 1){
            bWeight = batchItem.batchWeight;
          }else if(rollingTurn > 1){
            _rollingOutputItems.forEach((rollingOutputItem) {
              if ((rollingOutputItem.time.year == dateTime.year) &&
                  (rollingOutputItem.time.month == dateTime.month) &&
                  (rollingOutputItem.time.day == dateTime.day)){
                if((rollingOutputItem.batchNumber == batchNo) && (rollingOutputItem.rollingTurn == (rollingTurn - 1))){
                  _rollBreakingItems.forEach((rollBreakingItem) {
                    if ((rollBreakingItem.time.year == dateTime.year) &&
                        (rollBreakingItem.time.month == dateTime.month) &&
                        (rollBreakingItem.time.day == dateTime.day)){
                      if((rollBreakingItem.batchNumber == batchNo) && (rollBreakingItem.rollBreakingTurn == (rollingTurn - 1))){
                        bWeight = rollingOutputItem.weight - rollBreakingItem.weight;
                      }
                    }
                  });
                }
              }
            });
          }
        }
      }
    });
    return bWeight;
  }

  void addWitheringUnloadingBatchNumberItem(int batchNumberItem) {
    _batchNumberItems.add(batchNumberItem);
    notifyListeners();
  }

  double get latestBatchTotalWeight {
    var total = 0.0;
    _witheringUnloadingItems.forEach((witheringUnloadingItem) {
      if (witheringUnloadingItem.batchNumber == lastBatchNumberItem) {
        //Filter items which are having the latest batch number
        if ((witheringUnloadingItem.date.year == DateTime.now().year) &&
            (witheringUnloadingItem.date.month == DateTime.now().month) &&
            (witheringUnloadingItem.date.day == DateTime.now().day)) {
          //For those filtered items filter items which are entered today
          total += witheringUnloadingItem.lotWeight;
        }
      }
    });
    return total;
  }

  double witheringTroughBoxDatePercentage(
      {int troughNumber, int boxNumber, DateTime date, double lotWeight}) {//Taking inputs of the loft unloading
    double wither = 0.0;
    _troughLoadingItems.forEach((witheringLoadingItem) {
      if ((witheringLoadingItem.date.year == date.year) &&
          (witheringLoadingItem.date.month == date.month) &&
          ((witheringLoadingItem.date.day == date.day) ||
              (witheringLoadingItem.date.day == (date.day - 1)))) {//Taking the records of trough loading which is equal to trough unloading date or one day before. because sometimes trough unloading can take place one day after trough loading.

      print('for each : ' + '${witheringLoadingItem.troughNumber}' + '${witheringLoadingItem.boxNumber}');
        if (witheringLoadingItem.troughNumber == troughNumber)
          {
            print('inside 1 trough number : ' + '${witheringLoadingItem.troughNumber}' + '${witheringLoadingItem.boxNumber}');
            if(witheringLoadingItem.boxNumber == boxNumber) {//From those filtered records check and get the records which have the same trough number and the box number which is passed by the function input parameters which are the trough unloading details.
              print('inside 2 box number : ' + '${witheringLoadingItem.troughNumber}' + '${witheringLoadingItem.boxNumber}');
              wither = (100.0 - ((lotWeight / witheringLoadingItem.netWeight) * 100.0));
              //The filtered record is the same trough and box details we filled earlier, therefore we can divide the net weight of the loading from the lot weight of the unloading and get the percentage.
            }
          }

      }
    }
    );
    return wither;
  }

  int get lastBatchNumberItem {
    return _batchNumberItems[_batchNumberItems.length - 1];
  }

  List<WitheringUnloading> get witheringUnloadingItems {
    return [..._witheringUnloadingItems];
  }

  int get witheringUnloadingItemCount {
    return _witheringUnloadingItems.length;
  }

  WitheringUnloading findByIdUnload(String id) {
    return _witheringUnloadingItems
        .firstWhere((witherUnload) => witherUnload.id == id);
  }

  void addWitheringUnloadingItem(WitheringUnloading witheringUnloading) {
    final newWitheringUnloadingItem = WitheringUnloading(
      id: DateTime.now().toString(),
      batchNumber: witheringUnloading.batchNumber,
      troughNumber: witheringUnloading.troughNumber,
      boxNumber: witheringUnloading.boxNumber,
      date: DateTime.now(),
      lotWeight: witheringUnloading.lotWeight,
    );

    _witheringUnloadingItems.add(witheringUnloading);
    notifyListeners();
  }

  List<WitheringLoading> _troughLoadingItems = [];

  List<WitheringLoading> get troughLoadingItems {
    return [..._troughLoadingItems];
  }

  int get troughLoadingItemCount {
    return _troughLoadingItems.length;
  }

  WitheringLoading findByIdLoad(String id) {
    return _troughLoadingItems.firstWhere((troughLoad) => troughLoad.id == id);
  }

  void addTroughLoadingItem(WitheringLoading troughLoading) {
    final newTroughLoadingItem = WitheringLoading(
        id: DateTime.now().toString(),
        troughNumber: troughLoading.troughNumber,
        boxNumber: troughLoading.boxNumber,
        gradeOfGL: troughLoading.gradeOfGL,
        netWeight: troughLoading.netWeight);

    _troughLoadingItems.add(troughLoading);
    notifyListeners();
  }



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
