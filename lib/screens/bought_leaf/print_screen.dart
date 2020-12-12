import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/bought_leaf/tea_collections_provider.dart';
import 'package:teatrackerappofficer/widgets/card_container_printing_screen.dart';
import 'package:teatrackerappofficer/constants.dart';

class PrintScreen extends StatefulWidget {
  @override
  _PrintScreenState createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TeaCollections>(context, listen: false);
    final getCurrDate = provider.getCurrentDate();
    final deductions = provider.totalDeducts();

    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: kUIGradient,
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                          itemBuilder: (ctx, i) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        ),
                ),
              ),
            ),
            /*Container(
              child: Text(
                'DEDUCTIONS',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 15,
                ),
              ),
            ),*/
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
              child: Container(
                height: mediaQuery.height * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 400,),
                    Text(
                      'Total deductions: ',
                      style: TextStyle(color: Colors.white, fontSize: 35),
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
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: mediaQuery.height * 0.05,
              width: double.infinity,
              child: RaisedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed("TroughLoading");
                },
                icon: const Icon(Icons.print, color: Colors.white,),
                label: const Text(
                  'PRINT',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: const Color(0xff099857),
              ),
            )
          ],
        ),
      ),
    );
  }
}
