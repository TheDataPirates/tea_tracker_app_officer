import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teatrackerappofficer/providers/difference_report/difference_report.dart';
import 'package:teatrackerappofficer/providers/rolling/big_bulk.dart';
import 'package:teatrackerappofficer/providers/rolling/drying.dart';
import 'package:teatrackerappofficer/providers/rolling/fermenting.dart';
import 'package:teatrackerappofficer/providers/rolling/roll_breaking.dart';
import 'package:teatrackerappofficer/providers/rolling/rolling.dart';
import 'package:teatrackerappofficer/providers/withering/batch.dart';
import 'package:teatrackerappofficer/providers/withering/ended_loading_trough_box.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading.dart';
import 'package:teatrackerappofficer/providers/withering/withering_mixing.dart';
import 'package:teatrackerappofficer/providers/withering/withering_starting_finishing.dart';
import 'package:teatrackerappofficer/providers/withering/withering_unloading.dart';
import 'package:http/http.dart' as http;
import 'package:teatrackerappofficer/constants.dart';

class WitheringLoadingUnloadingRollingProvider with ChangeNotifier {
  //----------------Withering Starting-------------------

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
    const url = '$kURL/loft/starting';

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
          'time': DateTime.now().toIso8601String(),
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
    const url = '$kURL/loft/startings';
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
            troughNumber: int.parse(i['TroughTroughId'].toString()),
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

  bool isTroughStarted(int troughNumber, DateTime dateTime) {
    bool value = false;
    _witheringStartingItems.forEach((troughStarting) {
      if ((troughStarting.time.year == dateTime.year) &&
          (troughStarting.time.month == dateTime.month) &&
          (troughStarting.time.day == dateTime.day)) {
        if (troughStarting.troughNumber == troughNumber) {
          value = true;
        }
      }
    });
    return value;
  }

  //----------------Withering Mixing-------------------

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
    const url = '$kURL/loft/mixing';
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
          'time': DateTime.now().toIso8601String(),
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
    const url = '$kURL/loft/mixings';
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

  bool isBatchMixingTurnUsed(int troughNumber, int turn, DateTime dateTime) {
    bool value = false;
    _witheringMixingItems.forEach((witheringMixing) {
      if ((witheringMixing.time.year == dateTime.year) &&
          (witheringMixing.time.month == dateTime.month) &&
          (witheringMixing.time.day == dateTime.day)) {
        if (witheringMixing.troughNumber == troughNumber &&
            witheringMixing.turn == turn) {
          value = true;
        }
      }
    });
    return value;
  }

  String getCurrentDate() {
    final now = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

    return now;
  }

  //--------------------------- Withering Finishing ----------------------

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
    const url = '$kURL/loft/finishing';
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
    const url = '$kURL/loft/finishings';
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
            troughNumber: int.parse(i['TroughTroughId'].toString()),
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

  bool isTroughFinished(int troughNumber, DateTime dateTime) {
    bool value = false;
    _witheringFinishingItems.forEach((troughFinishing) {
      if ((troughFinishing.time.year == dateTime.year) &&
          (troughFinishing.time.month == dateTime.month) &&
          (troughFinishing.time.day == dateTime.day)) {
        if (troughFinishing.troughNumber == troughNumber) {
          value = true;
        }
      }
    });
    return value;
  }

  //----------------Batch -------------------

  List<int> _batchNumberItems = [];

  List<Batch> _batchItems = [];

  List<Batch> get batchItems {
    return [..._batchItems];
  }

  Future<void> addBatchItem(Batch batch, String authToken) async {
    final newBatchItem = Batch(
      id: DateTime.now().toString(),
      batchNumber: batch.batchNumber,
      batchWeight: batch.batchWeight,
      time: DateTime.now(),
    );
    const url = '$kURL/loft/batch';

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{
          'id': DateTime.now().toIso8601String(),
          'batchNumber': batch.batchNumber,
          'time': DateTime.now().toIso8601String(),
          'batchWeight': batch.batchWeight,
        }),
      );
      if (response.statusCode == 200) {
        _batchItems.add(batch);
        notifyListeners();
      } else {
        throw Exception('Failed ');
      }
    } catch (error) {
//      print(error);
      throw error;
    }
  }

  Future<void> fetchAndSetBatchItem(String authToken) async {
    _batchItems = [];
    const url = '$kURL/loft/batches';
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
      List Batches = extractedDataList['batches'];
      print(Batches);
      for (var i in Batches) {
        _batchItems.add(
          Batch(
            batchNumber: i['batch_no'] as int,
            time: DateTime.parse(i['batch_date']),
            batchWeight: double.parse(i['weight'].toString()),
          ),
        );
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  bool isBatchNumberUsed(int batchNumber, DateTime dateTime) {
    bool value = false;
    _batchItems.forEach((batch) {
      if ((batch.time.year == dateTime.year) &&
          (batch.time.month == dateTime.month) &&
          (batch.time.day == dateTime.day)) {
        if (batch.batchNumber == batchNumber) {
          value = true;
        }
      }
    });
    return value;
  }

  double batchWeight(int batchNo, DateTime dateTime, int rollingTurn) {
    double bWeight;
    _batchItems.forEach((batchItem) {
      if ((batchItem.time.year == dateTime.year) &&
          (batchItem.time.month == dateTime.month) &&
          (batchItem.time.day == dateTime.day)) {
        if (batchItem.batchNumber == batchNo) {
          if (rollingTurn == 1) {
            bWeight = batchItem.batchWeight;
          } else if (rollingTurn > 1) {
            _rollingOutputItems.forEach((rollingOutputItem) {
              if ((rollingOutputItem.time.year == dateTime.year) &&
                  (rollingOutputItem.time.month == dateTime.month) &&
                  (rollingOutputItem.time.day == dateTime.day)) {
                if ((rollingOutputItem.batchNumber == batchNo) &&
                    (rollingOutputItem.rollingTurn == (rollingTurn - 1))) {
                  _rollBreakingItems.forEach((rollBreakingItem) {
                    if ((rollBreakingItem.time.year == dateTime.year) &&
                        (rollBreakingItem.time.month == dateTime.month) &&
                        (rollBreakingItem.time.day == dateTime.day)) {
                      if ((rollBreakingItem.batchNumber == batchNo) &&
                          (rollBreakingItem.rollBreakingTurn ==
                              (rollingTurn - 1))) {
                        bWeight = rollingOutputItem.weightOut -
                            rollBreakingItem.weight;
                      }
                    }
                  });
                }
              }
            });
          }
        }
      }
    });
    return bWeight;
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

  int get lastBatchNumberItem {
    if (_batchNumberItems.isEmpty) {
      return -1;
    }
    return _batchNumberItems[_batchNumberItems.length - 1];
  }

  //----------------Withering -------------------

  void addWitheringUnloadingBatchNumberItem(int batchNumberItem) {
    _batchNumberItems.add(batchNumberItem);
    notifyListeners();
  }

  double witheringTroughBoxDatePercentage(
      {int troughNumber, int boxNumber, DateTime date, double lotWeight}) {
    //Taking inputs of the loft unloading
    double wither = 0.0;
    double totNetWeight = 0.0;
    _troughLoadingItems.forEach((witheringLoadingItem) {
      if ((witheringLoadingItem.date.year == date.year) &&
          (witheringLoadingItem.date.month == date.month) &&
          ((witheringLoadingItem.date.day == date.day) ||
              (witheringLoadingItem.date.day == (date.day - 1)))) {
        //Taking the records of trough loading which is equal to trough unloading date or one day before. because sometimes trough unloading can take place one day after trough loading.

//        print('for each : ' +
//            '${witheringLoadingItem.troughNumber}' +
//            '${witheringLoadingItem.boxNumber}');
        if (witheringLoadingItem.troughNumber == troughNumber) {
//          print('inside 1 trough number : ' +
//              '${witheringLoadingItem.troughNumber}' +
//              '${witheringLoadingItem.boxNumber}');
          if (witheringLoadingItem.boxNumber == boxNumber) {
            //From those filtered records check and get the records which have the same trough number and the box number which is passed by the function input parameters which are the trough unloading details.
//            print('inside 2 box number : ' +
//                '${witheringLoadingItem.troughNumber}' +
//                '${witheringLoadingItem.boxNumber}');
            totNetWeight += witheringLoadingItem.netWeight;
            //The filtered record is the same trough and box details we filled earlier, therefore we can divide the net weight of the loading from the lot weight of the unloading and get the percentage.
          }
        }
      }
    });
    wither = (100.0 - ((lotWeight / totNetWeight) * 100.0));
    return wither;
  }

  //----------------Withering Unloading -------------------

  List<WitheringUnloading> _witheringUnloadingItems = [];

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

  Future<void> addWitheringUnloadingItem(
      WitheringUnloading witheringUnloading, String authToken) async {
    final newWitheringUnloadingItem = WitheringUnloading(
      id: DateTime.now().toString(),
      batchNumber: witheringUnloading.batchNumber,
      troughNumber: witheringUnloading.troughNumber,
      boxNumber: witheringUnloading.boxNumber,
      date: DateTime.now(),
      lotWeight: witheringUnloading.lotWeight,
      witheringPct: witheringUnloading.witheringPct,
    );
    const url = '$kURL/loft/unloading';

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{
          'id': DateTime.now().toIso8601String(),
          'troughNumber': witheringUnloading.troughNumber,
          'date': DateTime.now().toIso8601String(),
          'boxNumber': witheringUnloading.boxNumber,
          'lotWeight': witheringUnloading.lotWeight,
          'batchNumber': witheringUnloading.batchNumber,
          'witheringPct': witheringUnloading.witheringPct,
          'unloadingTime': DateFormat('hh:mm:ss').format(DateTime.now())
        }),
      );
      if (response.statusCode == 200) {
        _witheringUnloadingItems.add(witheringUnloading);
        notifyListeners();
      } else {
        throw Exception('Failed ');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetWitheringUnloadingItem(String authToken) async {
    _witheringUnloadingItems = [];

    const url = '$kURL/loft/unloadings';
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
      List loadedLots = extractedDataList['unloadings'];
      print(loadedLots);
//      loadedLots = [];
      for (var i in loadedLots) {
        var BNum = i['box_id'].toString();
        var B_Num = BNum[3];

        _witheringUnloadingItems.add(
          WitheringUnloading(
            id: i['id'] as String,
            batchNumber: int.parse(i['BatchBatchNo'].toString()),
            date:
                i['date'] == null ? DateTime.now() : DateTime.parse(i['date']),
            troughNumber: int.parse(i['TroughTroughId'].toString()),
            lotWeight: double.parse(i['unloading_weight'].toString()),
            boxNumber: int.parse(B_Num),
            witheringPct: double.parse(i['withered_pct'].toString()),
          ),
        );
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  bool isTroughBoxUsed(int troughNo, int boxNo, DateTime dateTime) {
    bool value = false;
    _witheringUnloadingItems.forEach((unloading) {
      if ((unloading.date.year == dateTime.year) &&
          (unloading.date.month == dateTime.month) &&
          (unloading.date.day == dateTime.day)) {
        if (unloading.troughNumber == troughNo &&
            unloading.boxNumber == boxNo) {
          value = true;
        }
      }
    });
    return value;
  }

  bool isTroughBoxLoaded(int troughNo, int boxNo, DateTime dateTime) {
    bool value = false;
    _troughLoadingItems.forEach((troughLoading) {
      if ((troughLoading.date.year == dateTime.year) &&
          (troughLoading.date.month == dateTime.month) &&
          ((troughLoading.date.day == dateTime.day) ||
              (troughLoading.date.day == dateTime.day - 1))) {
        if (troughLoading.troughNumber == troughNo &&
            troughLoading.boxNumber == boxNo) {
          value = true;
        }
      }
    });
    return value;
  }

  //----------------Withering Loading -------------------

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

  Future<void> addTroughLoadingItem(
      WitheringLoading troughLoading, String authToken) async {
    final newTroughLoadingItem = WitheringLoading(
      id: DateTime.now().toString(),
      troughNumber: troughLoading.troughNumber,
      boxNumber: troughLoading.boxNumber,
      gradeOfGL: troughLoading.gradeOfGL,
      netWeight: troughLoading.netWeight,
      lotId: troughLoading.lotId,
      date: DateTime.now(),
    );
    const url = '$kURL/loft/loading';
    print(troughLoading.lotId);

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{
          'id': DateTime.now().toIso8601String(),
          'troughNumber': troughLoading.troughNumber,
          'date': DateTime.now().toIso8601String(),
          'boxNumber': troughLoading.boxNumber,
          'gradeOfGL': troughLoading.gradeOfGL,
          'netWeight': troughLoading.netWeight,
          'lotId': troughLoading.lotId,
          'loadingTime': DateFormat('hh:mm:ss').format(DateTime.now())
        }),
      );
      if (response.statusCode == 200) {
        _troughLoadingItems.add(troughLoading);
        notifyListeners();
      } else {
        throw Exception('Failed ');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetTroughLoadingItem(String authToken) async {
    _troughLoadingItems = [];
//    print('empty list');
//    print(troughLoadingItemCount);
    const url = '$kURL/loft/loadings';
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
      List loadedLots = extractedDataList['loadings'];
      print(loadedLots);
//      loadedLots = [];
      for (var i in loadedLots) {
        if (i['BoxBoxId'] == null) {
          _troughLoadingItems.add(
            WitheringLoading(
              id: i['lot_id'].toString(),
              lotId: i['lot_id'].toString(),
              troughNumber: 0,
              date: DateTime.now(),
              netWeight: double.parse(i['net_weight'].toString()),
              boxNumber: 0,
              gradeOfGL: i['grade_GL'].toString(),
            ),
          );
        } else {
          var TNum = i['BoxBoxId'].toString();
          var T_Num = TNum[1];
          var BNum = i['BoxBoxId'].toString();
          var B_Num = BNum[3];

          _troughLoadingItems.add(
            WitheringLoading(
              id: i['lot_id'].toString(),
              lotId: i['lot_id'].toString(),
              troughNumber: int.parse(T_Num),
              date: DateTime.now(),
              netWeight: double.parse(i['net_weight'].toString()),
              boxNumber: int.parse(B_Num),
              gradeOfGL: i['grade_GL'].toString(),
            ),
          );
        }

//        print(i);
      }
//      print(troughLoadingItemCount);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  int latestAddedLoadingTroughNumber() {
    return _troughLoadingItems[_troughLoadingItems.length - 1].troughNumber;
  }

  int latestAddedLoadingBoxNumber() {
    return _troughLoadingItems[_troughLoadingItems.length - 1].boxNumber;
  }

  double totalTroughBoxWeight(int troughNum, int boxNum, DateTime dateTime) {
    double totalWeight = 0;
    _troughLoadingItems.forEach((troughLoading) {
      if ((troughLoading.date.year == dateTime.year) &&
          (troughLoading.date.month == dateTime.month) &&
          (troughLoading.date.day == dateTime.day)) {
        if (troughLoading.troughNumber == troughNum &&
            troughLoading.boxNumber == boxNum) {
          totalWeight += troughLoading.netWeight;
        }
      }
    });
    return totalWeight;
  }

  bool isTroughBoxLeafGradeCorrect(
      int troughNumber, int boxNumber, String leafGrade, DateTime dateTime) {
    // print('Trough Loading Items');

    bool value = false;
    int troughBoxCount = 0;
    if (_troughLoadingItems.length == 0) {
      value = true;
    } else {
      _troughLoadingItems.forEach((troughLoadingItems) {
        print(troughLoadingItems.date);
        if ((troughLoadingItems.date.year == dateTime.year) &&
            (troughLoadingItems.date.month == dateTime.month) &&
            (troughLoadingItems.date.day == dateTime.day)) {
          if (troughLoadingItems.troughNumber == troughNumber &&
              troughLoadingItems.boxNumber == boxNumber) {
            // print(troughLoadingItems.troughNumber);
            // print(troughLoadingItems.boxNumber);
            // print('Existing grade');
            // print(troughLoadingItems.gradeOfGL);
            // print('Input grade');
            // print(leafGrade);
            troughBoxCount++;
            if (troughLoadingItems.gradeOfGL == leafGrade) {
              // print(troughLoadingItems.gradeOfGL);
              value = true;
            }
          }
        }
      });
      if (troughBoxCount == 0) {
        value = true;
      }
    }
    return value;
  }

  //----------------Ended Loading Trough Box -------------------

  List<EndedLoadingTroughBox> _endedLoadingTroughBoxItems = [];

  List<EndedLoadingTroughBox> get endedLoadingTroughBoxItems {
    return [..._endedLoadingTroughBoxItems];
  }

  int get endedLoadingTroughBoxItemCount {
    return _endedLoadingTroughBoxItems.length;
  }

  EndedLoadingTroughBox findByIdEndedLoad(String id) {
    return _endedLoadingTroughBoxItems
        .firstWhere((troughLoadEnd) => troughLoadEnd.id == id);
  }

  void addEndedLoadingTroughBoxItem(
      EndedLoadingTroughBox endedLoadingTroughBox) {
    final newEndedTroughLoadingItem = EndedLoadingTroughBox(
        id: DateTime.now().toString(),
        troughNumber: endedLoadingTroughBox.troughNumber,
        boxNumber: endedLoadingTroughBox.boxNumber,
        date: endedLoadingTroughBox.date);

    _endedLoadingTroughBoxItems.add(endedLoadingTroughBox);
//    notifyListeners();
  }

  bool isTroughBoxEnded(int troughNumber, int boxNumber, DateTime dateTime) {
    bool value = false;
    _endedLoadingTroughBoxItems.forEach((endedLoadingTroughBox) {
      if ((endedLoadingTroughBox.date.year == dateTime.year) &&
          (endedLoadingTroughBox.date.month == dateTime.month) &&
          (endedLoadingTroughBox.date.day == dateTime.day)) {
        if (endedLoadingTroughBox.troughNumber == troughNumber &&
            endedLoadingTroughBox.boxNumber == boxNumber) {
          value = true;
        }
      }
    });
    return value;
  }

  //----------------Big Bulk -------------------

  List<BigBulk> _bigBulkItems = [];

  List<BigBulk> get bigBulkItems {
    return [..._bigBulkItems];
  }

  int get bigBulkItemCount {
    return _bigBulkItems.length;
  }

  BigBulk findByIdBigBulk(String id) {
    return _bigBulkItems.firstWhere((bigBulk) => bigBulk.id == id);
  }

  Future<void> addBigBulkItem(BigBulk bigBulk, String authToken) async {
    final newBigBulkItem = BigBulk(
      id: DateTime.now().toString(),
      bigBulkNumber: bigBulk.bigBulkNumber,
      bigBulkWeight: bigBulk.bigBulkWeight,
      time: DateTime.now(),
    );
    const url = '$kURL/rolling/rbreaking';
    try {
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{
          'id': DateTime.now().toIso8601String(),
          'batchNumber': bigBulk.bigBulkNumber,
          'time': DateTime.now().toIso8601String(),
          'rollBreakingTurn': 'BB',
          'weight': bigBulk.bigBulkWeight,
        }),
      );
      if (response.statusCode == 200) {
        _bigBulkItems.add(bigBulk);
        notifyListeners();
      } else {
        throw Exception('Failed ');
      }
    } catch (error) {
      throw error;
    }
  }

  bool isBigBulkMade(int batchNumber, DateTime dateTime) {
    bool value = false;
    _bigBulkItems.forEach((bigBulk) {
      if ((bigBulk.time.year == dateTime.year) &&
          (bigBulk.time.month == dateTime.month) &&
          (bigBulk.time.day == dateTime.day)) {
        if (bigBulk.bigBulkNumber == batchNumber) {
          value = true;
        }
      }
    });
    return value;
  }

  //----------------Rolling Input -------------------

//  List<Rolling> _rollingInputItems = [];
//
//  List<Rolling> get rollingInputItems {
//    return [..._rollingInputItems];
//  }
//
//  int get rollingInputItemCount {
//    return _rollingInputItems.length;
//  }
//
//  Rolling findById(String id) {
//    return _rollingInputItems.firstWhere((rolling) => rolling.id == id);
//  }
//
//  void addRollingInputItem(Rolling rolling) {
//    final newRollingInputItem = Rolling(
//      id: DateTime.now().toString(),
//      batchNumber: rolling.batchNumber,
//      rollingTurn: rolling.rollingTurn,
//      rollerNumber: rolling.rollerNumber,
//      weightIn: rolling.weightIn,
//      time: DateTime.now(),
//    );
//
//    _rollingInputItems.add(rolling);
//    notifyListeners();
//  }

  //----------------Rolling Output -------------------

  List<Rolling> _rollingOutputItems = [];

  List<Rolling> get rollingOutputItems {
    return [..._rollingOutputItems];
  }

  int get rollingOutputItemCount {
    return _rollingOutputItems.length;
  }

  Rolling findByIdOutput(String id) {
    return _rollingOutputItems.firstWhere((rolling) => rolling.id == id);
  }

  Future<void> addRollingOutputItem(Rolling rolling, String authToken) async {
    final newRollingOutputItem = Rolling(
      id: DateTime.now().toString(),
      batchNumber: rolling.batchNumber,
      rollingTurn: rolling.rollingTurn,
      rollerNumber: rolling.rollerNumber,
      weightIn: rolling.weightIn,
      weightOut: rolling.weightOut,
      time: DateTime.now(),
    );
    const url = '$kURL/rolling/rolling';
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{
          'id': DateTime.now().toIso8601String(),
          'batchNumber': rolling.batchNumber,
          'time': DateTime.now().toIso8601String(),
          'rollingTurn': rolling.rollingTurn,
          'rollerNumber': rolling.rollerNumber,
          'weightIn': rolling.weightIn,
          'weightOut': rolling.weightOut,
        }),
      );
      if (response.statusCode == 200) {
        _rollingOutputItems.add(rolling);
        notifyListeners();
      } else {
        throw Exception('Failed ');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetRollingOutputItem(String authToken) async {
    _rollingOutputItems = [];
    const url = '$kURL/rolling/rollings';
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
      List rollings = extractedDataList['rollings'];
      print(rollings);
      for (var i in rollings) {
        _rollingOutputItems.add(
          Rolling(
            id: i['id'] as String,
            batchNumber: int.parse(i['BatchBatchNo'].toString()),
            time: i['rolling_out_time'] == null
                ? DateTime.now()
                : DateTime.parse(i['rolling_out_time']),
            rollerNumber: i['RollerRollerId'] == null
                ? 0
                : int.parse(i['RollerRollerId'].toString()),
            rollingTurn: i['rolling_turn'].toString() == 'BB'
                ? 'BB'
                : int.parse(i['rolling_turn'].toString()),
            weightIn: i['rolling_in_kg'] == null
                ? 0
                : double.parse(i['rolling_in_kg'].toString()),
            weightOut: i['rolling_out_kg'] == null
                ? 0
                : double.parse(i['rolling_out_kg'].toString()),
          ),
        );
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  bool isBatchRollingTurnAlreadyUsed(
      int batchNumber, int rollingTurn, DateTime dateTime) {
    bool value = false;
    _rollingOutputItems.forEach((rollingOutput) {
      if ((rollingOutput.time.year == dateTime.year) &&
          (rollingOutput.time.month == dateTime.month) &&
          (rollingOutput.time.day == dateTime.day)) {
        if (rollingOutput.batchNumber == batchNumber &&
            rollingOutput.rollingTurn == rollingTurn) {
          value = true;
        }
      }
    });
    return value;
  }

  bool isBatchEnded(int batchNumber, DateTime dateTime) {
    bool value = false;
    _bigBulkItems.forEach((bigBulk) {
      if ((bigBulk.time.year == dateTime.year) &&
          (bigBulk.time.month == dateTime.month) &&
          (bigBulk.time.day == dateTime.day)) {
        if (bigBulk.bigBulkNumber == batchNumber) {
          value = true;
        }
      }
    });
    return value;
  }

  bool isBatchMade(int batchNumber, DateTime dateTime) {
    bool value = false;
    _batchItems.forEach((batch) {
      if ((batch.time.year == dateTime.year) &&
          (batch.time.month == dateTime.month) &&
          (batch.time.day == dateTime.day)) {
        if (batch.batchNumber == batchNumber) {
          value = true;
        }
      }
    });
    return value;
  }

//  int inputedBatchRollingTurn(int batchNumber, DateTime dateTime){
//    int rollingTurn = 0;
//    _rollingInputItems.forEach((rollingInput) {
//      if ((rollingInput.time.year == dateTime.year) &&
//          (rollingInput.time.month == dateTime.month) &&
//          (rollingInput.time.day == dateTime.day)){
//        if(rollingInput.batchNumber == batchNumber){
//          rollingTurn = rollingInput.rollingTurn;
//        }
//      }
//    });
//    return rollingTurn;
//  }
//
//  int inputedBatchRollerNumber(int batchNumber, DateTime dateTime){
//    int rollerNumber = 0;
//    _rollingInputItems.forEach((rollingInput) {
//      if ((rollingInput.time.year == dateTime.year) &&
//          (rollingInput.time.month == dateTime.month) &&
//          (rollingInput.time.day == dateTime.day)){
//        if(rollingInput.batchNumber == batchNumber){
//          rollerNumber = rollingInput.rollerNumber;
//        }
//      }
//    });
//    return rollerNumber;
//  }
//
//  bool isBatchInputedForAParticularTurn(int batchNumber, int rollingTurn, DateTime dateTime){
//    bool value = false;
//    _rollingInputItems.forEach((rollingInput) {
//      if ((rollingInput.time.year == dateTime.year) &&
//          (rollingInput.time.month == dateTime.month) &&
//          (rollingInput.time.day == dateTime.day)){
//        if(rollingInput.batchNumber == batchNumber && rollingInput.rollingTurn == rollingTurn){
//          _rollingOutputItems.forEach((rollingOutput) {
//            if ((rollingOutput.time.year == dateTime.year) &&
//                (rollingOutput.time.month == dateTime.month) &&
//                (rollingOutput.time.day == dateTime.day)){
//              if(rollingOutput.batchNumber != batchNumber && rollingOutput.rollingTurn != rollingTurn){
//                value = true;
//              }
//            }
//          });
//        }
//      }
//    });
//    return value;
//  }

//----------------Roll Breaking -------------------

  List<RollBreaking> _rollBreakingItems = [];

  List<RollBreaking> get rollBreakingItems {
    return [..._rollBreakingItems];
  }

  int get rollBreakingItemCount {
    return _rollBreakingItems.length;
  }

  RollBreaking findByIdRollBreaking(String id) {
    return _rollBreakingItems
        .firstWhere((rollBreaking) => rollBreaking.id == id);
  }

  Future<void> addRollBreakingItem(
      RollBreaking rollBreaking, String authToken) async {
    final newRollBreakingItem = RollBreaking(
      id: DateTime.now().toString(),
      batchNumber: rollBreaking.batchNumber,
      rollBreakingTurn: rollBreaking.rollBreakingTurn,
      rollBreakerNumber: rollBreaking.rollBreakerNumber,
      weight: rollBreaking.weight,
      time: DateTime.now(),
    );
    const url = '$kURL/rolling/rbreaking';
    try {
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{
          'id': DateTime.now().toIso8601String(),
          'batchNumber': rollBreaking.batchNumber,
          'time': DateTime.now().toIso8601String(),
          'rollBreakingTurn': rollBreaking.rollBreakingTurn.toString(),
          'rollBreakerNumber': rollBreaking.rollBreakerNumber,
          'weight': rollBreaking.weight,
        }),
      );
      if (response.statusCode == 200) {
        _rollBreakingItems.add(rollBreaking);
        notifyListeners();
      } else {
        throw Exception('Failed ');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetWitheringRollBreakingItem(String authToken) async {
    _rollBreakingItems = [];
    const url = '$kURL/rolling/rbreakings';
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
      List loadedLots = extractedDataList['rollbreakings'];
      print(loadedLots);
      for (var i in loadedLots) {
        _rollBreakingItems.add(
          RollBreaking(
            id: i['id'] as String,
            batchNumber: int.parse(i['BatchBatchNo'].toString()),
            time: DateTime.parse(i['rb_out_time']),
            rollBreakerNumber:
                int.parse(i['RollBreakerRollBreakerId'].toString()),
            rollBreakingTurn: int.parse(i['rolling_turn'].toString()),
            weight: double.parse(i['dhool_out_weight'].toString()),
          ),
        );
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  int latestRollBreakingBatch() {
    int latestBatchNumber = 0;
    latestBatchNumber =
        _rollBreakingItems[_rollBreakingItems.length - 1].batchNumber;
    return latestBatchNumber;
  }

  int latestRollBreakingTurn() {
    int rollBreakingNumber = 0;
    rollBreakingNumber =
        _rollBreakingItems[_rollBreakingItems.length - 1].rollBreakingTurn;
    return rollBreakingNumber;
  }

  bool isBatchRollBreakingTurnAlreadyUsed(
      int batchNumber, int rollBreakingTurn, DateTime dateTime) {
    bool value = false;
    _rollBreakingItems.forEach((rollBreaking) {
      if ((rollBreaking.time.year == dateTime.year) &&
          (rollBreaking.time.month == dateTime.month) &&
          (rollBreaking.time.day == dateTime.day)) {
        if (rollBreaking.batchNumber == batchNumber &&
            rollBreaking.rollBreakingTurn == rollBreakingTurn) {
          value = true;
        }
      }
    });
    return value;
  }

  bool isDhoolMade(int batchNumber, dhoolNumber, DateTime dateTime) {
    bool value = false;
    _rollBreakingItems.forEach((rollBreaking) {
      if ((rollBreaking.time.year == dateTime.year) &&
          (rollBreaking.time.month == dateTime.month) &&
          (rollBreaking.time.day == dateTime.day)) {
        if (rollBreaking.batchNumber == batchNumber &&
            rollBreaking.rollBreakingTurn == dhoolNumber) {
          value = true;
        }
      }
    });
    return value;
  }

  //----------------Fermenting -------------------

  List<Fermenting> _fermentingItems = [];

  List<Fermenting> get fermentingItems {
    return [..._fermentingItems];
  }

  int get fermentingItemCount {
    return _fermentingItems.length;
  }

  Fermenting findByIdFermenting(String id) {
    return _fermentingItems.firstWhere((ferment) => ferment.id == id);
  }

  Future<void> addFermentingItem(
      Fermenting fermenting, String authToken) async {
    final newFermentingItem = Fermenting(
      id: DateTime.now().toString(),
      batchNumber: fermenting.batchNumber,
      dhoolNumber: fermenting.dhoolNumber,
      dhoolInWeight: fermenting.dhoolInWeight,
      dhoolOutWeight: fermenting.dhoolOutWeight,
      time: DateTime.now(),
    );
    const url = '$kURL/rolling/fermenting';
    try {
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{
          'id': DateTime.now().toIso8601String(),
          'batchNumber': newFermentingItem.batchNumber,
          'time': DateTime.now().toIso8601String(),
          'dhoolNumber': newFermentingItem.dhoolNumber.toString(),
          'dhoolInWeight': newFermentingItem.dhoolInWeight,
          'dhoolOutWeight': newFermentingItem.dhoolOutWeight,
        }),
      );
      if (response.statusCode == 200) {
        _fermentingItems.add(newFermentingItem);
        notifyListeners();
      } else {
        throw Exception('Failed ');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetFermentingItem(String authToken) async {
    _fermentingItems = [];
    const url = '$kURL/rolling/fermentings';
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
      List loadedLots = extractedDataList['fermentings'];
      print(loadedLots);
      for (var i in loadedLots) {
        _fermentingItems.add(
          Fermenting(
            id: i['id'].toString(),
            batchNumber: int.parse(i['BatchBatchNo'].toString()),
            time: DateTime.parse(i['fd_time_out']),
            dhoolInWeight: double.parse(i['dhool_out_weight'].toString()),
            dhoolNumber: i['rolling_turn'].toString(),
            dhoolOutWeight: double.parse(i['fd_out_kg'].toString()),
          ),
        );
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  double dhoolInputWeight(int batchNumber, DateTime dateTime, dhoolNum) {
    double dIWeight = 0;
    _rollBreakingItems.forEach((rollBreaking) {
      if ((rollBreaking.time.year == dateTime.year) &&
          (rollBreaking.time.month == dateTime.month) &&
          (rollBreaking.time.day == dateTime.day)) {
        if (rollBreaking.batchNumber == batchNumber) {
          if (dhoolNum == 'BB' || dhoolNum == 'bb') {
            _bigBulkItems.forEach((bigBulk) {
              if ((bigBulk.time.year == dateTime.year) &&
                  (bigBulk.time.month == dateTime.month) &&
                  (bigBulk.time.day == dateTime.day)) {
                if (bigBulk.bigBulkNumber == batchNumber) {
                  dIWeight = bigBulk.bigBulkWeight;
                }
              }
            });
          } else {
            if (rollBreaking.rollBreakingTurn == int.parse(dhoolNum)) {
              dIWeight = rollBreaking.weight;
            }
          }
        }
      }
    });
    return dIWeight;
  }

  bool isFermentedDhoolMade(
      int batchNumber, int dhoolNumber, DateTime dateTime) {
    bool value = false; //this should be false to work the validations
//    print('sent fd ' + '$dhoolNumber' + ' batch ' + '$batchNumber');
    _fermentingItems.forEach((fermenting) {
      if ((fermenting.time.year == dateTime.year) &&
          (fermenting.time.month == dateTime.month) &&
          (fermenting.time.day == dateTime.day)) {
//        print('saved fd ' + '${fermenting.dhoolNumber}' + ' batch ' + '${fermenting.batchNumber}');
        if (fermenting.dhoolNumber != 'BB') {
//          print('In != BB');
          if (fermenting.batchNumber == batchNumber) {
//            print('In batch ==');
//            print('sent fd : ' + '$dhoolNumber');
//            print('saved fd : ' + '${fermenting.dhoolNumber}');
            if (int.parse(fermenting.dhoolNumber) == dhoolNumber) {
//              print('value true saved fd ' + '${fermenting.dhoolNumber}');
              value = true;
            }
          }
        }
      }
    });
    return value;
  }

  bool isFermentedBigBulkMade(
      int batchNumber, String dhoolNumber, DateTime dateTime) {
    bool value = false; //this should be false to work the validations
//    print('sent fd ' + dhoolNumber + ' batch ' + '$batchNumber');
    _fermentingItems.forEach((fermenting) {
      if ((fermenting.time.year == dateTime.year) &&
          (fermenting.time.month == dateTime.month) &&
          (fermenting.time.day == dateTime.day)) {
//        print('saved fd ' + fermenting.dhoolNumber + ' batch ' + '${fermenting.batchNumber}');
        if (fermenting.dhoolNumber == 'BB') {
//          print('In == BB');
          if (fermenting.batchNumber == batchNumber) {
//            print('In batch ==');
            if (fermenting.dhoolNumber == dhoolNumber) {
//              print('value true saved fd ' + fermenting.dhoolNumber);
              value = true;
            }
          }
        }
      }
    });
    return value;
  }

  //----------------Drying -------------------

  List<Drying> _dryingItems = [];

  List<Drying> get dryingItems {
    return [..._dryingItems];
  }

  int get dryingItemCount {
    return _dryingItems.length;
  }

  Drying findByIdDrying(String id) {
    return _dryingItems.firstWhere((drying) => drying.id == id);
  }

  Future<void> addDryingItem(Drying drying, String authToken) async {
    final newDrierItem = Drying(
      id: DateTime.now().toString(),
      batchNumber: drying.batchNumber,
      dhoolNumber: drying.dhoolNumber,
      drierInWeight: drying.drierInWeight,
      drierOutWeight: drying.drierOutWeight,
      time: DateTime.now(),
      outturn: drying.outturn,
    );
//    print('Outturn');
//    print(newDrierItem.outturn);
    const url = '$kURL/rolling/drying';
    try {
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{
          'id': DateTime.now().toIso8601String(),
          'batchNumber': newDrierItem.batchNumber,
          'time': DateTime.now().toIso8601String(),
          'dhoolNumber': newDrierItem.dhoolNumber.toString(),
          'drierInWeight': newDrierItem.drierInWeight,
          'drierOutWeight': newDrierItem.drierOutWeight,
          'outturn': newDrierItem.outturn,
        }),
      );
      if (response.statusCode == 200) {
        _dryingItems.add(newDrierItem);
        notifyListeners();
      } else {
        throw Exception('Failed ');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetDryingItem(String authToken) async {
    _dryingItems = [];
    const url = '$kURL/rolling/dryings';
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
      List dryings = extractedDataList['dryings'];
      print(dryings);
      for (var i in dryings) {
        _dryingItems.add(
          Drying(
            id: i['id'].toString(),
            batchNumber: int.parse(i['BatchBatchNo'].toString()),
            time: DateTime.parse(i['drier_out_time']),
            drierInWeight: double.parse(i['fd_out_kg'].toString()),
            dhoolNumber: i['rolling_turn'].toString(),
            drierOutWeight: double.parse(i['drier_out_kg'].toString()),
          ),
        );
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  double drierInputWeight(int batchNumber, DateTime dateTime, dhoolNum) {
    double dryIWeight = 0;
    _fermentingItems.forEach((fermenting) {
      if ((fermenting.time.year == dateTime.year) &&
          (fermenting.time.month == dateTime.month) &&
          (fermenting.time.day == dateTime.day)) {
        if ((fermenting.batchNumber == batchNumber) &&
            (fermenting.dhoolNumber == dhoolNum)) {
          dryIWeight = fermenting.dhoolOutWeight;
        }
      }
    });
    return dryIWeight;
  }

  bool isDryedDhoolMade(int batchNumber, int dhoolNumber, DateTime dateTime) {
    bool value = false; //this should be false to work the validations
//    print('sent fd ' + '$dhoolNumber' + ' batch ' + '$batchNumber');
    _dryingItems.forEach((drying) {
      if ((drying.time.year == dateTime.year) &&
          (drying.time.month == dateTime.month) &&
          (drying.time.day == dateTime.day)) {
//        print('saved fd ' + '${fermenting.dhoolNumber}' + ' batch ' + '${fermenting.batchNumber}');
        if (drying.dhoolNumber != 'BB') {
//          print('In != BB');
          if (drying.batchNumber == batchNumber) {
//            print('In batch ==');
//            print('sent fd : ' + '$dhoolNumber');
//            print('saved fd : ' + '${fermenting.dhoolNumber}');
            if (int.parse(drying.dhoolNumber) == dhoolNumber) {
//              print('value true saved fd ' + '${fermenting.dhoolNumber}');
              value = true;
            }
          }
        }
      }
    });
    return value;
  }

  bool isDryedBigBulkMade(
      int batchNumber, String dhoolNumber, DateTime dateTime) {
    bool value = false; //this should be false to work the validations
//    print('sent fd ' + dhoolNumber + ' batch ' + '$batchNumber');
    _dryingItems.forEach((drying) {
      if ((drying.time.year == dateTime.year) &&
          (drying.time.month == dateTime.month) &&
          (drying.time.day == dateTime.day)) {
//        print('saved fd ' + fermenting.dhoolNumber + ' batch ' + '${fermenting.batchNumber}');
        if (drying.dhoolNumber == 'BB') {
//          print('In == BB');
          if (drying.batchNumber == batchNumber) {
//            print('In batch ==');
            if (drying.dhoolNumber == dhoolNumber) {
//              print('value true saved fd ' + fermenting.dhoolNumber);
              value = true;
            }
          }
        }
      }
    });
    return value;
  }

//----------------Outturn -------------------

  double totalDayOutturn(DateTime dateTime) {
    double totOutturn = 0;
    double totIn = 0;
    double totOut = 0;
    _troughLoadingItems.forEach((troughLoading) {
      if ((troughLoading.date.year == dateTime.year) &&
          (troughLoading.date.month == dateTime.month) &&
          ((troughLoading.date.day == dateTime.day) ||
              (troughLoading.date.day == dateTime.day - 1))) {
        totIn += troughLoading.netWeight;
      }
    });
    _dryingItems.forEach((dryingItem) {
      if ((dryingItem.time.year == dateTime.year) &&
          (dryingItem.time.month == dateTime.month) &&
          (dryingItem.time.day == dateTime.day)) {
        totOut += dryingItem.drierOutWeight;
      }
    });
    totOutturn = (totOut / totIn) * 100.0;
    return totOutturn;
  }

  double batchOutturn(int batchNum, DateTime dateTime) {
//    print("Inside Outturn fuunc");
//    print(batchNum);
    double totOutturn = 0;
    double totIn = 0;
    double totOut = 0;
    int batchTrough = 0;
    int batchBox = 0;
    _witheringUnloadingItems.forEach((witheringUnloading) {
      if ((witheringUnloading.date.year == dateTime.year) &&
          (witheringUnloading.date.month == dateTime.month) &&
          (witheringUnloading.date.day == dateTime.day)) {
        if (witheringUnloading.batchNumber == batchNum) {
          batchTrough = witheringUnloading.troughNumber;
          batchBox = witheringUnloading.boxNumber;
          _troughLoadingItems.forEach((troughLoading) {
            if ((troughLoading.date.year == dateTime.year) &&
                (troughLoading.date.month == dateTime.month) &&
                ((troughLoading.date.day == dateTime.day) ||
                    (troughLoading.date.day == dateTime.day - 1))) {
              if (troughLoading.troughNumber == batchTrough &&
                  troughLoading.boxNumber == batchBox) {
                totIn += troughLoading.netWeight;
              }
            }
          });
        }
      }
    });
    _dryingItems.forEach((dryingItem) {
      if ((dryingItem.time.year == dateTime.year) &&
          (dryingItem.time.month == dateTime.month) &&
          (dryingItem.time.day == dateTime.day)) {
        if (dryingItem.batchNumber == batchNum) {
          totOut += dryingItem.drierOutWeight;
        }
      }
    });
    totOutturn = (totOut / totIn) * 100.0;
    return totOutturn;
  }

  double batchOutturnWithDrierWeight(
      int batchNum, DateTime dateTime, double drierOutWeight) {
//    print("Inside Outturn fuunc");
//    print(batchNum);
    double totOutturn = 0;
    double totIn = 0;
    double totOut = drierOutWeight;
    int batchTrough = 0;
    int batchBox = 0;
    _witheringUnloadingItems.forEach((witheringUnloading) {
      if ((witheringUnloading.date.year == dateTime.year) &&
          (witheringUnloading.date.month == dateTime.month) &&
          (witheringUnloading.date.day == dateTime.day)) {
        if (witheringUnloading.batchNumber == batchNum) {
          batchTrough = witheringUnloading.troughNumber;
          batchBox = witheringUnloading.boxNumber;
          _troughLoadingItems.forEach((troughLoading) {
            if ((troughLoading.date.year == dateTime.year) &&
                (troughLoading.date.month == dateTime.month) &&
                ((troughLoading.date.day == dateTime.day) ||
                    (troughLoading.date.day == dateTime.day - 1))) {
              if (troughLoading.troughNumber == batchTrough &&
                  troughLoading.boxNumber == batchBox) {
                totIn += troughLoading.netWeight;
              }
            }
          });
        }
      }
    });
    _dryingItems.forEach((dryingItem) {
      if ((dryingItem.time.year == dateTime.year) &&
          (dryingItem.time.month == dateTime.month) &&
          (dryingItem.time.day == dateTime.day)) {
        if (dryingItem.batchNumber == batchNum) {
          totOut += dryingItem.drierOutWeight;
        }
      }
    });
    totOutturn = (totOut / totIn) * 100.0;
    return totOutturn;
  }

//----------------Difference Report -------------------

  List<DifferenceReport> _differenceReportItems = [];

  List<DifferenceReport> get differenceReportItems {
    return [..._differenceReportItems];
  }

  int get differenceReportItemsCount {
    return _differenceReportItems.length;
  }

  Future<void> fetchAndSetDifferenceReportItem(String authToken) async {
    _differenceReportItems = [];
    const url = '$kURL/diff/dreports';
    const url2 = '$kURL/diff/dreport';
    try {
      final response = await http.patch(
        url2,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{}),
      );
      if (response.statusCode == 200) {
        final dataList = await http.get(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $authToken'
          },
        );
        final extractedDataList = jsonDecode(dataList.body);
//      print(extractedDataList);
        List differenceReport = extractedDataList['dreports'];
        print(differenceReport);
        for (var i in differenceReport) {
          _differenceReportItems.add(
            DifferenceReport(
              reportId: i['report_id'].toString(),
              originalWeight: double.parse(i['original_weight'].toString()),
              remeasuringWeight:
                  double.parse(i['remeasuring_weight'].toString()),
              weightDifference: double.parse(i['weight_difference'].toString()),
              supplierId: i['supplier_id'].toString(),
            ),
          );
        }
        notifyListeners();
      } else {
        throw Exception('Failed ');
      }
    } catch (error) {
      throw error;
    }
  }
}
