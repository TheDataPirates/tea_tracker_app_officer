import 'package:flutter/material.dart';
import 'trough_loading.dart';

class TroughArrangement with ChangeNotifier {
  List<TroughLoading> _troughLoadingItems = [
    TroughLoading(
        id: 'ID1',
        troughNumber: 1,
        boxNumber: 1,
        gradeOfGL: 'A',
        netWeight: 100.0),
    TroughLoading(
        id: 'ID2',
        troughNumber: 2,
        boxNumber: 2,
        gradeOfGL: 'B',
        netWeight: 200.0),
    TroughLoading(
        id: 'ID3',
        troughNumber: 3,
        boxNumber: 3,
        gradeOfGL: 'C',
        netWeight: 300.0),
    TroughLoading(
        id: 'ID4',
        troughNumber: 4,
        boxNumber: 4,
        gradeOfGL: 'A',
        netWeight: 400.0)
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
