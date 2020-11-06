import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'withering_mixing.dart';
import 'package:http/http.dart' as http;

class WitheringMixingProvider with ChangeNotifier {
  List<WitheringMixing> _witheringMixingItems = [];
  List<WitheringMixing> get witheringMixingItems {
    return [..._witheringMixingItems];
  }

  int get witheringMixingItemCount {
    return _witheringMixingItems.length;
  }

  WitheringMixing findById(String id) {
    return _witheringMixingItems.firstWhere((troughMix) => troughMix.id == id);
  }

  Future<void> addWitheringMixingItem(
      WitheringMixing witheringMixing, String authToken) async {
    const url = 'http://10.0.2.2:8080/loft/mixing';
    final newWitheringMixingItem = WitheringMixing(
        id: DateTime.now().toString(),
        troughNumber: witheringMixing.troughNumber,
        turn: witheringMixing.turn,
        time: DateTime.now(),
        temperature: witheringMixing.temperature,
        humidity: witheringMixing.humidity);
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{
          'id': DateTime.now().toIso8601String(),
          'troughNumber': witheringMixing.troughNumber,
          'time': getCurrentDate(),
          'temperature': witheringMixing.temperature,
          'humidity': witheringMixing.humidity,
          'process_name': 'mixing${witheringMixing.turn}'
        }),
      );
      if (response.statusCode == 200) {
        _witheringMixingItems.add(witheringMixing);
        notifyListeners();
      } else {
        throw Exception('Failed ');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetWitheringMixingItem(String authToken) async {
    _witheringMixingItems = [];
    const url = 'http://10.0.2.2:8080/loft/mixings';
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
      List loadedLots = extractedDataList['mixings'];
      print(loadedLots);
      for (var i in loadedLots) {
        _witheringMixingItems.add(
          WitheringMixing(
            id: i['tp_id'] as String,
            troughNumber: i['TroughTroughId'] as int,
            time: DateTime.parse(i['date']),
            turn: getMixingturn(i['ProcessProcessName']),
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

  int getMixingturn(String proc_name) {
    var mixingTurn = proc_name;
    switch (mixingTurn) {
      case 'mixing1':
        {
          return int.parse('1');
        }
        break;
      case 'mixing2':
        {
          return int.parse('2');
        }
        break;
      case 'mixing3':
        {
          return int.parse('3');
        }
        break;
    }
  }

  String getCurrentDate() {
    final now = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

    return now;
  }
}
