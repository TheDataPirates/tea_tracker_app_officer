import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/bought_leaf/tea_collections_provider.dart';
import '../../constants.dart';

class ListTileLot extends StatelessWidget {
  final String lotId;

  ListTileLot({
    this.lotId,
  });

  @override
  Widget build(BuildContext context) {
    final selectedLot = Provider.of<TeaCollections>(context)
        .lot_items
        .firstWhere((supp) =>
            supp.lotId ==
            lotId); // provider will check selected supp id and give its lots object data along to class
    return Scaffold(
      appBar: AppBar(
        title: Text("LOT details"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image : viewScreenBackgroundImage,
        gradient: kUIGradient,
      ),
        child: Column(
          children: [
//          Container(
//            width: double.infinity,
//            child: Card(
//              margin: EdgeInsets.all(10),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: [
//                  const Text("Supplier :", style: kTextLotlistStyle),
//                  Text(selectedLot.supplier_id, style: kTextLotlistStyle),
//                ],
//              ),
//            ),
//          ),
//          Container(
//            width: double.infinity,
//            child: Card(
//              margin: EdgeInsets.all(10),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: [
//                  const Text("Container type :", style: kTextLotlistStyle),
//                  Text(selectedLot.container_type, style: kTextLotlistStyle),
//                ],
//              ),
//            ),
//          ),
            Container(
              width: double.infinity,
              child: Card(
                margin: EdgeInsets.all(10),
                color:  Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Number of containers :",
                          style: kTextLotlistStyle),
                      Text("${selectedLot.no_of_containers}",
                          style: kTextLotlistStyle),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                margin: EdgeInsets.all(10),
                color:  Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Gross weight :", style: kTextLotlistStyle),
                      Text(selectedLot.gross_weight.toString(),
                          style: kTextLotlistStyle),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                margin: EdgeInsets.all(10),
                color:  Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Leaf grade :", style: kTextLotlistStyle),
                      Text(selectedLot.leaf_grade, style: kTextLotlistStyle)
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                margin: EdgeInsets.all(10),
                color:  Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Water % :", style: kTextLotlistStyle),
                      Text(selectedLot.water.toString(), style: kTextLotlistStyle)
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                margin: EdgeInsets.all(10),
                color:  Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Course leaf % :", style: kTextLotlistStyle),
                      Text(selectedLot.course_leaf.toString(),
                          style: kTextLotlistStyle)
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                margin: EdgeInsets.all(10),
                color:  Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Other % :", style: kTextLotlistStyle),
                      Text(selectedLot.other.toString(), style: kTextLotlistStyle)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
