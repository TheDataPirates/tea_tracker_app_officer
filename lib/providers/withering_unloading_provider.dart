import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/providers/withering_unloading.dart';

class WitheringUnloadingProvider with ChangeNotifier{
  List<WitheringUnloading> _witheringUnloadingItems = [

  ];

  List<int> _batchNumberItems = [];

  void addWitheringUnloadingBatchNumberItem(int batchNumberItem) {
    _batchNumberItems.add(batchNumberItem);
    notifyListeners();
  }

  double get totalBatchWeight{
    var total = 0.0;
    _witheringUnloadingItems.forEach((witheringUnloadingItem) {
      total += witheringUnloadingItem.lotWeight;
    });
    return total;
  }

  int get lastBatchNumberItem{
    return _batchNumberItems[_batchNumberItems.length-1];
  }

  List<WitheringUnloading> get witheringUnloadingItems {
    return [..._witheringUnloadingItems];
  }

  int get witheringUnloadingItemCount{
    return _witheringUnloadingItems.length;
  }

  WitheringUnloading findByIdUnload(String id){
    return _witheringUnloadingItems.firstWhere((witherUnload) => witherUnload.id ==  id);
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



}