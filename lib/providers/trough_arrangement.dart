import 'package:flutter/material.dart';
import 'trough_loading.dart';

class TroughArrangement with ChangeNotifier {
  List<TroughLoading> _troughLoadingItems = [

  ];

  List<TroughLoading> get troughLoadingItems {
    return [..._troughLoadingItems];
  }

  int get troughLoadingItemCount{
    return _troughLoadingItems.length;
  }

  TroughLoading fingById(String id){
    return _troughLoadingItems.firstWhere((troughLoad) => troughLoad.id ==  id);
  }

  void addTroughLoadingItem(TroughLoading troughLoading) {
    final newTroughLoadingItem = TroughLoading(
        id: DateTime.now().toString(),
        troughNumber: troughLoading.troughNumber,
        boxNumber: troughLoading.boxNumber,
        gradeOfGL: troughLoading.gradeOfGL,
        netWeight: troughLoading.netWeight);

    _troughLoadingItems.add(troughLoading);
    notifyListeners();
  }
}
