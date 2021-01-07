import 'dart:ffi';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import './lot.dart';
import './supplier.dart';
import 'package:date_format/date_format.dart';

class TeaCollections with ChangeNotifier {
  List<Lot> _lot_items = [];

  List<Lot> get lot_items {
    return [..._lot_items];
  }

  int Bulkid;
  int reportId;
  int lotTotDeduct;

  Supplier _newSupplier;
//  = Supplier("unknown",
//      "unknown"); //set default value otherwise throws exception cant find supplierID

  Supplier get newSupplier => _newSupplier;

  Future<void> addLot(
    String authToken,
    String supNo,
    String supName,
    String contType,
    int noOfCont,
    int gWeight,
    String lGrade,
    int water,
    int cLeaf,
    int other,
    int deducts,
    int nWeight,
  ) async {
    //create lot object
    final lotid = DateTime.now().toIso8601String();
    final newLot = Lot(
      lotId: lotid,
      supplier_id: supNo,
      supplier_name: supName,
      container_type: contType,
      no_of_containers: noOfCont,
      gross_weight: gWeight,
      leaf_grade: lGrade,
      water: water,
      course_leaf: cLeaf,
      other: other,
      deductions: deducts,
      net_weight: nWeight,
    );
    const url = 'http://10.0.2.2:8080/bleaf/lot';
    try {
      await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{
          'lot_id': lotid,
          'grade_GL': newLot.leaf_grade,
          'gross_weight': newLot.gross_weight,
          'container_type': newLot.container_type,
          'no_of_container': newLot.no_of_containers,
          'water': newLot.water,
          'course_leaf': newLot.course_leaf,
          'other': newLot.other,
          'net_weight': newLot.net_weight,
          'deduction': newLot.deductions,
          'bulkId': Bulkid
        }),
      );
      _lot_items.add(newLot); // add new obj to items array

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchAndSetLotData(
      String id, String date, String authToken) async {
    const url = 'http://10.0.2.2:8080/bleaf/lots';
    _lot_items = [];
    try {
      final dataList = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
      );
      final extractedDataList = jsonDecode(dataList.body);
      print(extractedDataList);
      List loadedLots = extractedDataList['lots'];
      print(loadedLots);
      for (var i in loadedLots) {
        _lot_items.add(
          Lot(
              lotId: i['lot_id'],
              no_of_containers: i['no_of_container'],
              leaf_grade: i['grade_GL'],
              gross_weight: i['gross_weight'],
              water: i['water'],
              course_leaf: i['course_leaf'],
              other: i['other'],
              net_weight: i['net_weight'],
              deductions: i['deduction'],
              container_type: i['container_type']),
        );
      }

      notifyListeners();
    } catch (error) {
      print(error);
    } //raw query to get isdeleted = 0
  }

  Future<void> deleteLot(String id, String authToken) async {
    final url = 'http://10.0.2.2:8080/bleaf/lot/$id';
    // remove lot from the array
    try {
      final response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
      );
      if (response.statusCode == 500) {
        // check whether server sent bad respond
        throw Exception('Failed ');
      } else if (response.statusCode == 200) {
        // respond okay. without having else part this future not return anything, not worked calling placed.
        _lot_items.removeWhere((lot) => lot.lotId == id);
      }
    } catch (error) {
      print(error);
      throw error;
    }
    notifyListeners();
  }

  int calDeduct(int water, int cleaf, int other, int gweight, String contType,
      int noOfCont) {
    // calculated deductions lot wise
    double contDeducts;
    int deductPercnt = water + cleaf + other;
    switch (contType) {
      case 'A':
        {
          contDeducts = 0.5 * noOfCont;
          gweight = (gweight - contDeducts).toInt();
          double deductDouble =
              ((gweight * deductPercnt) / 100) + (0.5 * noOfCont);
          lotTotDeduct = deductDouble.toInt();
          return deductDouble.toInt();
        }
        break;
      case 'B':
        {
          contDeducts = 0.75 * noOfCont;
          gweight = (gweight - contDeducts).toInt();
          double deductDouble =
              ((gweight * deductPercnt) / 100) + (0.75 * noOfCont);
          lotTotDeduct = deductDouble.toInt();
          return deductDouble.toInt();
        }
        break;
      case 'C':
        {
          contDeducts = 1.0 * noOfCont;
          gweight = (gweight - contDeducts).toInt();
          double deductDouble =
              ((gweight * deductPercnt) / 100) + (1.0 * noOfCont);
          lotTotDeduct = deductDouble.toInt();
          return deductDouble.toInt();
        }
        break;
      case 'D':
        {
          contDeducts = 1.25 * noOfCont;
          gweight = (gweight - contDeducts).toInt();
          double deductDouble =
              ((gweight * deductPercnt) / 100) + (1.25 * noOfCont);
          lotTotDeduct = deductDouble.toInt();
          return deductDouble.toInt();
        }
        break;
      case 'E':
        {
          contDeducts = 0.0 * noOfCont;
          gweight = (gweight - contDeducts).toInt();
          double deductDouble =
              ((gweight * deductPercnt) / 100) + (0.0 * noOfCont);
          lotTotDeduct = deductDouble.toInt();
          return deductDouble.toInt();
        }
        break;
    }
  }

  int calNetWeight(int gWeight) {
    // calculate net weight lot wise
    return (gWeight - lotTotDeduct);
  }

  int totalDeducts() {
    // use in print screen
    try {
      int total = 0;
      lot_items.forEach((item) => total += item.deductions);
      return total;
    } catch (e) {
      print(e);
    }
  }

  Future<void> verifySupplier(String supId, String supName, String authToken,
      String userId, String method) async {
    //when use async await whole func wrap into future. so no need to must return.
    const url = 'http://10.0.2.2:8080/bleaf/bulk';
    const url2 = 'http://10.0.2.2:8080/diff/dreport';

    Bulkid = Random().nextInt(100000000);
    reportId = Random().nextInt(100000000);

    try {
      final response = await http.post(
        //
        //creates a bulk record on the mysql
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{
          'bulk_id': Bulkid,
          'user_id': userId,
          'supplier_id': supId,
          'method': method,
          'date': getCurrentDate(),
        }),
      );

      if (response.statusCode == 500 || response.statusCode == 404) {
        // check whether server sent bad respond
        throw Exception('Failed ');
      } else if (response.statusCode == 200 && method == 'OfficerOriginal') {
        // respond okay. without having else part this future not return anything, not worked calling placed.
        _newSupplier = Supplier(supId, supName);

        // await http.post(
        //   //
        //   //creates a bulk record on the mysql
        //   url2,
        //   headers: <String, String>{
        //     'Content-Type': 'application/json; charset=UTF-8',
        //     'Authorization': 'Bearer $authToken'
        //   },
        //   body: jsonEncode(<String, dynamic>{
        //     'report_id': reportId,
        //     'bulk_id': Bulkid,
        //   }),
        // );
      } else if (response.statusCode == 200 && method == 'Remeasuring') {
        _newSupplier = Supplier(supId, supName);

        await http.post(
          //
          //creates a bulk record on the mysql
          url2,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $authToken'
          },
          body: jsonEncode(<String, dynamic>{
            'report_id': reportId,
            'bulk_id': Bulkid,
          }),
        );
      }
    } catch (err) {
      print(err);
      throw err;
    }
  }

  String getCurrentDate() {
    final now = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

    return now;
  }

  Lot get lastLotNumberItem {
    return lot_items[lot_items.length - 1];
  }
}
