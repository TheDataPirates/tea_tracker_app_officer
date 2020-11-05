import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/providers/withering/withering_starting_finishing.dart';
import 'package:http/http.dart' as http;

class WitheringStartingFinishingProvider with ChangeNotifier {
  List<WitheringStartingFinishing> _witheringStartingItems = [];
  List<WitheringStartingFinishing> get witheringStartingItems {
    return [..._witheringStartingItems];
  }

  int get witheringStartingItemCount {
    return _witheringStartingItems.length;
  }

  WitheringStartingFinishing findByIdStart(String id) {
    return _witheringStartingItems
        .firstWhere((witherStart) => witherStart.id == id);
  }

  Future<void> addWitheringStartingItem(
      WitheringStartingFinishing witheringStarting, String authToken) async {
    final newWitheringStartingItem = WitheringStartingFinishing(
        id: DateTime.now().toString(),
        troughNumber: witheringStarting.troughNumber,
        time: DateTime.now(),
        temperature: witheringStarting.temperature,
        humidity: witheringStarting.humidity);
    const url = 'http://10.0.2.2:8080/loft/starting';

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{
          'id': DateTime.now().toIso8601String(),
          'troughNumber': witheringStarting.troughNumber,
          'time': getCurrentDate(),
          'temperature': witheringStarting.temperature,
          'humidity': witheringStarting.humidity,
          'process_name': 'starting'
        }),
      );
      if (response.statusCode == 200) {
        _witheringStartingItems.add(newWitheringStartingItem);
        notifyListeners();
      } else {
        throw Exception('Failed ');
      }
    } catch (error) {
      throw error;
    }
  }

  List<WitheringStartingFinishing> _witheringFinishingItems = [];
  List<WitheringStartingFinishing> get witheringFinishingItems {
    return [..._witheringFinishingItems];
  }

  int get witheringFinishingItemCount {
    return _witheringFinishingItems.length;
  }

  WitheringStartingFinishing findByIdFinish(String id) {
    return _witheringFinishingItems
        .firstWhere((witherFinish) => witherFinish.id == id);
  }

  void addWitheringFinishingItem(
      WitheringStartingFinishing witheringFinishing) {
    final newWitheringFinishingItem = WitheringStartingFinishing(
        id: DateTime.now().toString(),
        troughNumber: witheringFinishing.troughNumber,
        time: DateTime.now(),
        temperature: witheringFinishing.temperature,
        humidity: witheringFinishing.humidity);

    _witheringFinishingItems.add(witheringFinishing);
    notifyListeners();
  }

  String getCurrentDate() {
    final now = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

    return now;
  }
}
