import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/providers/withering_unloading.dart';
import 'package:teatrackerappofficer/providers/withering_loading.dart';

class WitheringLoadingUnloadingProvider with ChangeNotifier {
  List<WitheringUnloading> _witheringUnloadingItems = [];

  List<int> _batchNumberItems = [];

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
              wither = ((lotWeight / witheringLoadingItem.netWeight) * 100.0);
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
}
