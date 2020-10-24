import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/providers/withering/withering_starting_finishing.dart';


class WitheringStartingFinishingProvider with ChangeNotifier{
  List<WitheringStartingFinishing> _witheringStartingItems = [

  ];
  List<WitheringStartingFinishing> get witheringStartingItems {
    return [..._witheringStartingItems];
  }

  int get witheringStartingItemCount{
    return _witheringStartingItems.length;
  }

  WitheringStartingFinishing findByIdStart(String id){
    return _witheringStartingItems.firstWhere((witherStart) => witherStart.id ==  id);
  }

  void addWitheringStartingItem(WitheringStartingFinishing witheringStarting) {
    final newWitheringStartingItem = WitheringStartingFinishing(
        id: DateTime.now().toString(),
        troughNumber: witheringStarting.troughNumber,
        time: DateTime.now(),
        temperature: witheringStarting.temperature,
        humidity: witheringStarting.humidity);

    _witheringStartingItems.add(witheringStarting);
    notifyListeners();
  }

  List<WitheringStartingFinishing> _witheringFinishingItems = [

  ];
  List<WitheringStartingFinishing> get witheringFinishingItems {
    return [..._witheringFinishingItems];
  }

  int get witheringFinishingItemCount{
    return _witheringFinishingItems.length;
  }

  WitheringStartingFinishing findByIdFinish(String id){
    return _witheringFinishingItems.firstWhere((witherFinish) => witherFinish.id ==  id);
  }

  void addWitheringFinishingItem(WitheringStartingFinishing witheringFinishing) {
    final newWitheringFinishingItem = WitheringStartingFinishing(
        id: DateTime.now().toString(),
        troughNumber: witheringFinishing.troughNumber,
        time: DateTime.now(),
        temperature: witheringFinishing.temperature,
        humidity: witheringFinishing.humidity);

    _witheringFinishingItems.add(witheringFinishing);
    notifyListeners();
  }
}