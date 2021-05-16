import 'package:date_time_format/date_time_format.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';


class Receipt {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  sample(String officerId, String supId, String supName, int grossWeight, int totalDeducts, int netWeight) async {
    DateTime dateTime = DateTime.now();
    var currentTime = dateTime.format('H:i');
    var currentDate = dateTime.format('d/m/Y');

    // ignore: unnecessary_statements
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.printNewLine();
        bluetooth.printCustom("Kudamalana Tea", 4, 1);
        bluetooth.printCustom("Factory", 4, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom(currentDate.toString(), 2, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom(currentTime.toString(), 2, 1);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("Officer ID :", officerId.toString(), 1);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("Supplier ID :", supId.toString(), 1);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("Supplier Name :", supName.toString(), 1);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("Gross Weight :", grossWeight.toString() + " Kg", 1);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("Total Deduction", totalDeducts.toString() + " Kg", 1);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("Net Weight :", netWeight.toString() + " Kg", 1);
        bluetooth.printNewLine();
        bluetooth.printCustom("Thank You ...!", 3, 1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }

}