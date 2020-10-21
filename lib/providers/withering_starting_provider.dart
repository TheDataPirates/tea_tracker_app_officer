import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/providers/withering_starting.dart';


class WitheringStartingProvider with ChangeNotifier{
  List<WitheringStarting> _witheringStartingItems = [

  ];
  List<WitheringStarting> get witheringStartingItems {
    return [..._witheringStartingItems];
  }

  int get witheringStartingItemCount{
    return _witheringStartingItems.length;
  }

  WitheringStarting findById(String id){
    return _witheringStartingItems.firstWhere((witherStart) => witherStart.id ==  id);
  }

  void addWitheringStartingItem(WitheringStarting witheringStarting) {
    final newWitheringStartingItem = WitheringStarting(
        id: DateTime.now().toString(),
        troughNumber: witheringStarting.troughNumber,
        time: DateTime.now(),
        temperature: witheringStarting.temperature,
        humidity: witheringStarting.humidity);

    _witheringStartingItems.add(witheringStarting);
    notifyListeners();
  }
}