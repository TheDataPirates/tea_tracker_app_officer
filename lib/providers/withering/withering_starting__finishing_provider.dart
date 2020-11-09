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

  Future<void> fetchAndSetWitheringStartingItem(String authToken) async {
    _witheringStartingItems = [];
    const url = 'http://10.0.2.2:8080/loft/startings';
    try {
      final dataList = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
      );
      final extractedDataList = jsonDecode(dataList.body);
//      print(extractedDataList);
      List loadedLots = extractedDataList['startings'];
      print(loadedLots);
      for (var i in loadedLots) {
        _witheringStartingItems.add(
          WitheringStartingFinishing(
            id: i['tp_id'] as String,
            troughNumber: i['TroughTroughId'] as int,
            time: DateTime.parse(i['date']),
            temperature: double.parse(i['temperature'].toString()),
            humidity: double.parse(i['humidity'].toString()),
          ),
        );
      }
      notifyListeners();
    } catch (error) {
      print(error);
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

  Future<void> addWitheringFinishingItem(
      WitheringStartingFinishing witheringFinishing, String authToken) async {
    final newWitheringFinishingItem = WitheringStartingFinishing(
        id: DateTime.now().toString(),
        troughNumber: witheringFinishing.troughNumber,
        time: DateTime.now(),
        temperature: witheringFinishing.temperature,
        humidity: witheringFinishing.humidity);
    const url = 'http://10.0.2.2:8080/loft/finishing';
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{
          'id': DateTime.now().toIso8601String(),
          'troughNumber': witheringFinishing.troughNumber,
          'time': DateTime.now().toIso8601String(),
          'temperature': witheringFinishing.temperature,
          'humidity': witheringFinishing.humidity,
          'process_name': 'finishing'
        }),
      );
      if (response.statusCode == 200) {
        _witheringFinishingItems.add(witheringFinishing);
        notifyListeners();
      } else {
        throw Exception('Failed ');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetWitheringFinishingItem(String authToken) async {
    _witheringFinishingItems = [];
    const url = 'http://10.0.2.2:8080/loft/finishings';
    try {
      final dataList = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
      );
      final extractedDataList = jsonDecode(dataList.body);
//      print(extractedDataList);
      List loadedLots = extractedDataList['finishings'];
      print(loadedLots);
      for (var i in loadedLots) {
        _witheringFinishingItems.add(
          WitheringStartingFinishing(
            id: i['tp_id'] as String,
            troughNumber: i['TroughTroughId'] as int,
            time: DateTime.parse(i['date']),
            temperature: double.parse(i['temperature'].toString()),
            humidity: double.parse(i['humidity'].toString()),
          ),
        );
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  String getCurrentDate() {
    final now = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

    return now;
  }
}
