import 'package:flutter/material.dart';
import 'withering_mixing.dart';

class WitheringMixingProvider with ChangeNotifier{
  List<WitheringMixing> _witheringMixingItems = [

  ];
  List<WitheringMixing> get witheringMixingItems {
    return [..._witheringMixingItems];
  }

  int get witheringMixingItemCount{
    return _witheringMixingItems.length;
  }

  WitheringMixing findById(String id){
    return _witheringMixingItems.firstWhere((troughMix) => troughMix.id ==  id);
  }

  void addWitheringMixingItem(WitheringMixing witheringMixing) {
    final newWitheringMixingItem = WitheringMixing(
        id: DateTime.now().toString(),
        troughNumber: witheringMixing.troughNumber,
        turn: witheringMixing.turn,
        time: DateTime.now(),
        temperature: witheringMixing.temperature,
        humidity: witheringMixing.humidity);

    _witheringMixingItems.add(witheringMixing);
    notifyListeners();
  }
}