import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/bought_leaf/tea_collections_provider.dart';
import '../bought_leaf/lot_list_screen.dart';

import '../../constants.dart';

class BoughtLeafScreen extends StatelessWidget {
  final supplierNoEditingController = TextEditingController();
  final supplierNameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> saveLot() async {
      if (supplierNoEditingController.text.isEmpty ||
          supplierNameEditingController.text.isEmpty) {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('AlertDialog'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const Text('No supplier name entered'),
                    const Text('Please Enter again'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        Provider.of<TeaCollections>(context, listen: false).saveSupplier(
            supplierNoEditingController.text,
            supplierNameEditingController.text);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LotListScreen(
              supplierID: supplierNoEditingController.text,
              supplierName: supplierNameEditingController.text,
            ),
          ),
        );
      }
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      controller: supplierNoEditingController,
                      obscureText: false,
                      style: const TextStyle(fontSize: 40.0),
                      decoration: InputDecoration(
                        labelText: "Supplier No :",
                        labelStyle: kTextLotlistStyle,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      controller: supplierNameEditingController,
                      style: const TextStyle(fontSize: 40.0),
                      decoration: InputDecoration(
                        labelStyle: kTextLotlistStyle,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        labelText: "Supplier Name :",
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
//            height: MediaQuery.of(context).size.height * 0.05,
            child: RaisedButton.icon(
              onPressed: () {
                saveLot();
              },
              icon: Icon(Icons.add),
              label: const Text(
                'SAVE',
                style: const TextStyle(fontSize: 20),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Colors.amber,
            ),
          )
        ],
      ),
    );
  }
}
