import 'dart:ffi';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './lot.dart';
import './supplier.dart';
import 'package:date_format/date_format.dart';

class TeaCollections with ChangeNotifier {
  List<Lot> _lot_items = [];

  List<Lot> get lot_items {
    return [..._lot_items];
  }

  int lotTotDeduct;

  Supplier _newSupplier;
//  = Supplier("unknown",
//      "unknown"); //set default value otherwise throws exception cant find supplierID

  Supplier get newSupplier => _newSupplier;

  Future<void> addLot(
    String Id,
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
    final newLot = Lot(
      lotId: Id,
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
        body: json.encode({
          'lot_id': newLot.lotId,
          'grade_GL': newLot.leaf_grade,
          'gross_weight': newLot.gross_weight,
          'no_of_container': newLot.no_of_containers,
          'water': newLot.water,
          'course_leaf': newLot.course_leaf,
          'other': newLot.other,
          'net_weight': newLot.net_weight,
          'deduction': newLot.deductions,
        }),
      );
      _lot_items.add(newLot); // add new obj to items array

      notifyListeners();
    } catch (error) {
      print(error);
//      throw error;
    }
  }
//getting all records
//  Future<void> fetchAndSetLotData() async {
//    final dataList = await DBHelper.getData('lots');
//
//    _lot_items = dataList
//        .map(
//          (item) => Lot(
//            lotId: item['lotId'],
//            supplier_id: item['supplier_id'],
//            supplier_name: item['supplier_name'],
//            container_type: item['container_type'],
//            no_of_containers: item['no_of_containers'],
//            leaf_grade: item['leaf_grade'],
//            gross_weight: item['g_weight'],
//            water: item['water'],
//            course_leaf: item['course_leaf'],
//            other: item['other'],
//            date: item['date'],
//          ),
//        )
//        .toList();
//    notifyListeners();
//  }

  Future<void> fetchAndSetLotData(String id, String date) async {
    const url = 'http://10.0.2.2:8080/bleaf/lots';
    try {
      final dataList = await http.get(url);
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
          ),
        );
      }

//      print(extractedDataLits);
//      final List<Lot> loadedLots = [];
//      extractedDataLits.forEach((key, lotData) {
//        print(key);
//        print(lotData);
//        _lot_items = lotData
//            .map(
//              (lotdata) => Lot(
//                  lotId: lotdata['lot_id'],
//                  no_of_containers: lotdata['no_of_container'],
//                  leaf_grade: lotdata['grade_GL'],
//                  gross_weight: lotdata['gross_weight'],
//                  water: lotdata['water'],
//                  course_leaf: lotdata['course_leaf'],
//                  other: lotdata['other'],
//                  net_weight: lotdata['net_weight'],
//                  deductions: lotdata['deduction'],
//                  date: lotdata['date']),
//            )
//            .toList();
//      });
//        loadedLots.add(
//          Lot(
//              lotId: lotData['lot_id'],
//              no_of_containers: lotData['no_of_container'],
//              leaf_grade: lotData['grade_GL'],
//              gross_weight: lotData['gross_weight'],
//              water: lotData['water'],
//              course_leaf: lotData['course_leaf'],
//              other: lotData['other'],
//              net_weight: lotData['net_weight'],
//              deductions: lotData['deduction'],
//              date: lotData['date']),
//        );
//      });
//      _lot_items = Lots;
      notifyListeners();
    } catch (error) {
      print(error);
    } //raw query to get isdeleted = 0
  }

  void deleteLot(String id) {
    _lot_items
        .removeWhere((lot) => lot.lotId == id); // remove lot from the array
//    DBHelper.deleteLot(1, id); // setting isDeleted = 1 in sqldb
    notifyListeners();
  }

  int calDeduct(int water, int cleaf, int other, int gweight) {
    // calculated deductions lot wise
    int deductPercnt = water + cleaf + other;
    double deductDouble = ((gweight * deductPercnt) / 100);
    lotTotDeduct = deductDouble.toInt();
    return deductDouble.toInt();
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
      print(total);
      return total;
    } catch (e) {
      print(e);
    }
  }

  void saveSupplier(String supId, String supName) {
    _newSupplier = Supplier(supId, supName);

    notifyListeners();
  }

  String getCurrentDate() {
    final now = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    print(now);
    return now;
  }
}
