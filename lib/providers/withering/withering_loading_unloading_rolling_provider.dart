import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/providers/rolling/big_bulk.dart';
import 'package:teatrackerappofficer/providers/rolling/drying.dart';
import 'package:teatrackerappofficer/providers/rolling/fermenting.dart';
import 'package:teatrackerappofficer/providers/rolling/roll_breaking.dart';
import 'package:teatrackerappofficer/providers/rolling/rolling.dart';
import 'package:teatrackerappofficer/providers/withering/batch.dart';
import 'package:teatrackerappofficer/providers/withering/ended_loading_trough_box.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading.dart';
import 'package:teatrackerappofficer/providers/withering/withering_unloading.dart';

class WitheringLoadingUnloadingRollingProvider with ChangeNotifier {
  //----------------Batch -------------------

  List<int> _batchNumberItems = [];

  List<Batch> _batchItems = [];

  List<Batch> get batchItems {
    return [..._batchItems];
  }

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

  bool isBatchNumberUsed (int batchNumber, DateTime dateTime){
    bool value = false;
    _batchItems.forEach((batch) {
      if ((batch.time.year == dateTime.year) &&
          (batch.time.month == dateTime.month) &&
          (batch.time.day == dateTime.day)){
        if(batch.batchNumber == batchNumber){
          value = true;
        }
      }
    });
    return value;
  }

  double batchWeight(int batchNo, DateTime dateTime, int rollingTurn) {
    double bWeight;
    _batchItems.forEach((batchItem) {
      if ((batchItem.time.year == dateTime.year) &&
          (batchItem.time.month == dateTime.month) &&
          (batchItem.time.day == dateTime.day)) {
        if (batchItem.batchNumber == batchNo) {
          if (rollingTurn == 1) {
            bWeight = batchItem.batchWeight;
          } else if (rollingTurn > 1) {
            _rollingOutputItems.forEach((rollingOutputItem) {
              if ((rollingOutputItem.time.year == dateTime.year) &&
                  (rollingOutputItem.time.month == dateTime.month) &&
                  (rollingOutputItem.time.day == dateTime.day)) {
                if ((rollingOutputItem.batchNumber == batchNo) &&
                    (rollingOutputItem.rollingTurn == (rollingTurn - 1))) {
                  _rollBreakingItems.forEach((rollBreakingItem) {
                    if ((rollBreakingItem.time.year == dateTime.year) &&
                        (rollBreakingItem.time.month == dateTime.month) &&
                        (rollBreakingItem.time.day == dateTime.day)) {
                      if ((rollBreakingItem.batchNumber == batchNo) &&
                          (rollBreakingItem.rollBreakingTurn ==
                              (rollingTurn - 1))) {
                        bWeight =
                            rollingOutputItem.weight - rollBreakingItem.weight;
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

  int get lastBatchNumberItem {
    return _batchNumberItems[_batchNumberItems.length - 1];
  }

  //----------------Withering -------------------

  void addWitheringUnloadingBatchNumberItem(int batchNumberItem) {
    _batchNumberItems.add(batchNumberItem);
    notifyListeners();
  }

  double witheringTroughBoxDatePercentage(
      {int troughNumber, int boxNumber, DateTime date, double lotWeight}) {
    //Taking inputs of the loft unloading
    double wither = 0.0;
    _troughLoadingItems.forEach((witheringLoadingItem) {
      if ((witheringLoadingItem.date.year == date.year) &&
          (witheringLoadingItem.date.month == date.month) &&
          ((witheringLoadingItem.date.day == date.day) ||
              (witheringLoadingItem.date.day == (date.day - 1)))) {
        //Taking the records of trough loading which is equal to trough unloading date or one day before. because sometimes trough unloading can take place one day after trough loading.

        print('for each : ' +
            '${witheringLoadingItem.troughNumber}' +
            '${witheringLoadingItem.boxNumber}');
        if (witheringLoadingItem.troughNumber == troughNumber) {
          print('inside 1 trough number : ' +
              '${witheringLoadingItem.troughNumber}' +
              '${witheringLoadingItem.boxNumber}');
          if (witheringLoadingItem.boxNumber == boxNumber) {
            //From those filtered records check and get the records which have the same trough number and the box number which is passed by the function input parameters which are the trough unloading details.
            print('inside 2 box number : ' +
                '${witheringLoadingItem.troughNumber}' +
                '${witheringLoadingItem.boxNumber}');
            wither = (100.0 -
                ((lotWeight / witheringLoadingItem.netWeight) * 100.0));
            //The filtered record is the same trough and box details we filled earlier, therefore we can divide the net weight of the loading from the lot weight of the unloading and get the percentage.
          }
        }
      }
    });
    return wither;
  }

  //----------------Withering Unloading -------------------

  List<WitheringUnloading> _witheringUnloadingItems = [];

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

  bool isTroughBoxUsed(int troughNo, int boxNo, DateTime dateTime){
    bool value = false;
    _witheringUnloadingItems.forEach((unloading) {
      if ((unloading.date.year == dateTime.year) &&
          (unloading.date.month == dateTime.month) &&
          (unloading.date.day == dateTime.day)){
        if(unloading.troughNumber == troughNo && unloading.boxNumber == boxNo){
          value = true;
        }
      }
    });
    return value;
  }

  //----------------Withering Loading -------------------

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

  int latestAddedLoadingTroughNumber(){
    return _troughLoadingItems[_troughLoadingItems.length-1].troughNumber;
  }

  int latestAddedLoadingBoxNumber(){
    return _troughLoadingItems[_troughLoadingItems.length-1].boxNumber;
  }

  double totalTroughBoxWeight(int troughNum, int boxNum, DateTime dateTime){
    double totalWeight = 0;
    _troughLoadingItems.forEach((troughLoading) {
      if ((troughLoading.date.year == dateTime.year) &&
          (troughLoading.date.month == dateTime.month) &&
          (troughLoading.date.day == dateTime.day)){
        if(troughLoading.troughNumber == troughNum && troughLoading.boxNumber == boxNum){
          totalWeight += troughLoading.netWeight;
        }
      }
    });
    return totalWeight;
  }

  bool isTroughBoxLeafGradeCorrect (int troughNumber, int boxNumber, String leafGrade, DateTime dateTime){
    bool value = false;
    int troughBoxCount = 0;
    if(_troughLoadingItems.length == 0){
      value = true;
    }else{
      _troughLoadingItems.forEach((troughLoadingItems) {
        if ((troughLoadingItems.date.year == dateTime.year) &&
            (troughLoadingItems.date.month == dateTime.month) &&
            (troughLoadingItems.date.day == dateTime.day)){
          if(troughLoadingItems.troughNumber == troughNumber && troughLoadingItems.boxNumber == boxNumber){
            troughBoxCount ++;
            if(troughLoadingItems.gradeOfGL == leafGrade){
              value = true;
            }
          }
        }
      });
      if(troughBoxCount == 0){
        value = true;
      }
    }
    return value;
  }

  //----------------Ended Loading Trough Box -------------------

  List<EndedLoadingTroughBox> _endedLoadingTroughBoxItems = [];

  List<EndedLoadingTroughBox> get endedLoadingTroughBoxItems {
    return [..._endedLoadingTroughBoxItems];
  }

  int get endedLoadingTroughBoxItemCount {
    return _endedLoadingTroughBoxItems.length;
  }

  EndedLoadingTroughBox findByIdEndedLoad(String id) {
    return _endedLoadingTroughBoxItems.firstWhere((troughLoadEnd) => troughLoadEnd.id == id);
  }

  void addEndedLoadingTroughBoxItem(EndedLoadingTroughBox endedLoadingTroughBox) {
    final newEndedTroughLoadingItem = EndedLoadingTroughBox(
        id: DateTime.now().toString(),
        troughNumber: endedLoadingTroughBox.troughNumber,
        boxNumber: endedLoadingTroughBox.boxNumber,
        date: endedLoadingTroughBox.date
    );

    _endedLoadingTroughBoxItems.add(endedLoadingTroughBox);
    notifyListeners();
  }

  bool isTroughBoxEnded (int troughNumber, int boxNumber, DateTime dateTime){
    bool value = false;
    _endedLoadingTroughBoxItems.forEach((endedLoadingTroughBox) {
      if ((endedLoadingTroughBox.date.year == dateTime.year) &&
          (endedLoadingTroughBox.date.month == dateTime.month) &&
          (endedLoadingTroughBox.date.day == dateTime.day)){
        if(endedLoadingTroughBox.troughNumber == troughNumber && endedLoadingTroughBox.boxNumber == boxNumber){
          value = true;
        }
      }
    });
    return value;
  }



  //----------------Big Bulk -------------------

  List<BigBulk> _bigBulkItems = [];

  List<BigBulk> get bigBulkItems {
    return [..._bigBulkItems];
  }

  int get bigBulkItemCount {
    return _bigBulkItems.length;
  }

  BigBulk findByIdBigBulk(String id) {
    return _bigBulkItems.firstWhere((bigBulk) => bigBulk.id == id);
  }

  void addBigBulkItem(BigBulk bigBulk) {
    final newBigBulkItem = BigBulk(
      id: DateTime.now().toString(),
      bigBulkNumber: bigBulk.bigBulkNumber,
      bigBulkWeight: bigBulk.bigBulkWeight,
      time: DateTime.now(),
    );

    _bigBulkItems.add(bigBulk);
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
    return _rollBreakingItems
        .firstWhere((rollBreaking) => rollBreaking.id == id);
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

  int latestRollBreakingBatch() {
    int latestBatchNumber = 0;
    latestBatchNumber =
        _rollBreakingItems[_rollBreakingItems.length - 1].batchNumber;
    return latestBatchNumber;
  }

  int latestRollBreakingTurn() {
    int rollBreakingNumber = 0;
    rollBreakingNumber =
        _rollBreakingItems[_rollBreakingItems.length - 1].rollBreakingTurn;
    return rollBreakingNumber;
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

  double dhoolInputWeight(int batchNumber, DateTime dateTime, dhoolNum) {
    double dIWeight = 0;
    _rollBreakingItems.forEach((rollBreaking) {
      if ((rollBreaking.time.year == dateTime.year) &&
          (rollBreaking.time.month == dateTime.month) &&
          (rollBreaking.time.day == dateTime.day)) {
        if (rollBreaking.batchNumber == batchNumber) {
          if (dhoolNum == 'BB' || dhoolNum == 'bb') {
            _bigBulkItems.forEach((bigBulk) {
              if ((bigBulk.time.year == dateTime.year) &&
                  (bigBulk.time.month == dateTime.month) &&
                  (bigBulk.time.day == dateTime.day)) {
                if (bigBulk.bigBulkNumber == batchNumber) {
                  dIWeight = bigBulk.bigBulkWeight;
                }
              }
            });
          } else {
            if (rollBreaking.rollBreakingTurn == int.parse(dhoolNum)) {
              dIWeight = rollBreaking.weight;
            }
          }
        }
      }
    });
    return dIWeight;
  }

  //----------------Drying -------------------

  List<Drying> _dryingItems = [];

  List<Drying> get dryingItems {
    return [..._dryingItems];
  }

  int get dryingItemCount {
    return _dryingItems.length;
  }

  Drying findByIdDrying(String id) {
    return _dryingItems.firstWhere((drying) => drying.id == id);
  }

  void addDryingItem(Drying drying) {
    final newDrierItem = Drying(
      id: DateTime.now().toString(),
      batchNumber: drying.batchNumber,
      dhoolNumber: drying.dhoolNumber,
      drierInWeight: drying.drierInWeight,
      drierOutWeight: drying.drierOutWeight,
      time: DateTime.now(),
    );

    _dryingItems.add(drying);
    notifyListeners();
  }

  double drierInputWeight(int batchNumber, DateTime dateTime, dhoolNum) {
    double dryIWeight = 0;
    _fermentingItems.forEach((fermenting) {
      if ((fermenting.time.year == dateTime.year) &&
          (fermenting.time.month == dateTime.month) &&
          (fermenting.time.day == dateTime.day)) {
        if ((fermenting.batchNumber == batchNumber) &&
            (fermenting.dhoolNumber == dhoolNum)) {
          dryIWeight = fermenting.dhoolOutWeight;
        }
      }
    });
    return dryIWeight;
  }

//----------------Outturn -------------------

  double totalDayOutturn(DateTime dateTime) {
    double totOutturn = 0;
    double totIn = 0;
    double totOut = 0;
    _troughLoadingItems.forEach((troughLoading) {
      if ((troughLoading.date.year == dateTime.year) &&
          (troughLoading.date.month == dateTime.month) &&
          ((troughLoading.date.day == dateTime.day) ||
              (troughLoading.date.day == dateTime.day - 1))) {
        totIn += troughLoading.netWeight;
      }
    });
    _dryingItems.forEach((dryingItem) {
      if ((dryingItem.time.year == dateTime.year) &&
          (dryingItem.time.month == dateTime.month) &&
          (dryingItem.time.day == dateTime.day)) {
        totOut += dryingItem.drierOutWeight;
      }
    });
    totOutturn = (totOut / totIn) * 100.0;
    return totOutturn;
  }

  double batchOutturn(int batchNum, DateTime dateTime) {
    double totOutturn = 0;
    double totIn = 0;
    double totOut = 0;
    int batchTrough = 0;
    int batchBox = 0;
    _witheringUnloadingItems.forEach((witheringUnloading) {
      if ((witheringUnloading.date.year == dateTime.year) &&
          (witheringUnloading.date.month == dateTime.month) &&
          (witheringUnloading.date.day == dateTime.day)) {
        if (witheringUnloading.batchNumber == batchNum) {
          batchTrough = witheringUnloading.troughNumber;
          batchBox = witheringUnloading.boxNumber;
          _troughLoadingItems.forEach((troughLoading) {
            if ((troughLoading.date.year == dateTime.year) &&
                (troughLoading.date.month == dateTime.month) &&
                ((troughLoading.date.day == dateTime.day) ||
                    (troughLoading.date.day == dateTime.day - 1))) {
              if (troughLoading.troughNumber == batchTrough &&
                  troughLoading.boxNumber == batchBox) {
                totIn += troughLoading.netWeight;
              }
            }
          });
        }
      }
    });
    _dryingItems.forEach((dryingItem) {
      if ((dryingItem.time.year == dateTime.year) &&
          (dryingItem.time.month == dateTime.month) &&
          (dryingItem.time.day == dateTime.day)) {
        if (dryingItem.batchNumber == batchNum) {
          totOut += dryingItem.drierOutWeight;
        }
      }
    });
    totOutturn = (totOut / totIn) * 100.0;
    return totOutturn;
  }
}
