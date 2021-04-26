import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/bought_leaf/tea_collections_provider.dart';
import 'package:teatrackerappofficer/widgets/card_container_printing_screen.dart';
import 'package:teatrackerappofficer/constants.dart';

class PrintPreviewScreen extends StatefulWidget {
  @override
  _PrintScreenState createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TeaCollections>(context, listen: false);
    final getCurrDate = provider.getCurrentDate();
    final deductions = provider.totalDeducts();

    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: printScreenBackgroundImage,
          gradient: kUIGradient,
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:  EdgeInsets.all(mediaQuery.width * 0.005),
                child: Consumer<TeaCollections>(
                  child: Center(
                    child: const Text('Got no lots yet', style: kEmptyViewText,),
                  ),
                  builder: (ctx, teaCollections, ch) => teaCollections
                              .lot_items.length <=
                          0
                      ? ch
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: teaCollections.lot_items.length,
                          itemBuilder: (ctx, i) => Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CardContainer(
                                  mediaQuery: mediaQuery,
                                  lotData:
                                      teaCollections.lot_items[i].container_type,
                                  labelText: 'Container type',
                                ),
                                CardContainer(
                                    mediaQuery: mediaQuery,
                                    lotData: teaCollections.lot_items[i].leaf_grade,
                                    labelText: 'Grade of GL'),
                                CardContainer(
                                    mediaQuery: mediaQuery,
                                    lotData: teaCollections
                                        .lot_items[i].no_of_containers,
                                    labelText: 'Number of Containers'),
                                CardContainer(
                                    mediaQuery: mediaQuery,
                                    lotData:
                                        teaCollections.lot_items[i].gross_weight,
                                    labelText: 'Gross Weight'),
                              ],
                            ),
                            padding: EdgeInsets.only(top: mediaQuery.height * 0.01,bottom: mediaQuery.height * 0.01),
                          ),
                        ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Container(
              child: Text(
                'DEDUCTIONS',
                style: TextStyle(
                  fontSize: mediaQuery.height * 0.06,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 10,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding:
                   EdgeInsets.symmetric(vertical: mediaQuery.height * 0.025, horizontal: mediaQuery.width * 0.045),
              child: Container(
                height: mediaQuery.height * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: mediaQuery.width * 0.2,
                      height: mediaQuery.height * 0.1,
                      child: Card(
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.greenAccent.shade700,
                        child: Center(
                          child: Text(
                            getCurrDate,
                            style: TextStyle(color: Colors.white, fontSize: mediaQuery.height * 0.05),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Total deductions',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: mediaQuery.height * 0.06,
                          fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // SizedBox(width: 0.05,),
                    Container(
                      width: mediaQuery.width * 0.2,
                      height: mediaQuery.height * 0.1,
                      child: Card(
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.greenAccent.shade700,
                        child: Center(
                          child: Text(
                            "$deductions KG",
                            style: TextStyle(color: Colors.white, fontSize: mediaQuery.height * 0.05),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: mediaQuery.height * 0.075,
              width: double.infinity,
              child: RaisedButton.icon(
                onPressed: () {
                  // Navigator.popUntil(context, ModalRoute.withName('MainMenu'));
                  Navigator.of(context).pushNamed("PrintScreen");
                },
                icon:  Icon(Icons.print, color: Colors.white, size: mediaQuery.height * 0.06,),
                label:  Text(
                  'PRINT',
                  style: TextStyle(fontSize: mediaQuery.height * 0.05, color: Colors.white),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: const Color(0xff099857).withOpacity(0.8),
              ),
            )
          ],
        ),
      ),
    );
  }
}
