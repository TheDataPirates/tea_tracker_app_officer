import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/bought_leaf/tea_collections_provider.dart';
import 'package:teatrackerappofficer/constants.dart';

class ReMeasuring extends StatefulWidget {
  @override
  _ReMeasuringScreen createState() => _ReMeasuringScreen();
}

class _ReMeasuringScreen extends State<ReMeasuring> {
  final supplierNoEditingController = TextEditingController();

  final supplierNameEditingController = TextEditingController();

  Future<void> submit() async {
    final auth = Provider.of<Auth>(context, listen: false);
    String token = auth.token;
    String user = auth.user_id;
    if (supplierNoEditingController.text.isEmpty &&
        supplierNameEditingController.text.isEmpty) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('AlertDialog'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text('No supplier id or name entered'),
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
      try {
        await Provider.of<TeaCollections>(context, listen: false)
            .verifySupplier(supplierNoEditingController.text,
                supplierNameEditingController.text, token, user, "Remeasuring");
        print('bulk saved');
        Navigator.of(context).pushNamed('ReInputcollectionScreen');
      } catch (error) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('AlertDialog'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('An error occurred'),
                    Text(error.toString()),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image : inputScreenBackgroundImage,
          gradient: kUIGradient,
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextField(
                        controller: supplierNoEditingController,
                        obscureText: false,
                        style: const TextStyle(fontSize: 40.0, color: kTextInputColor),
                        decoration: InputDecoration(
                          labelText: "Supplier No :",
                          labelStyle: kSupplierTextFormFieldText,
                          fillColor:textFieldfillColor,
                          filled: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          enabledBorder: kEnabledBorder,
                          focusedBorder: kFocusedBorder,
                          // border: OutlineInputBorder(
                          //   borderRadius: const BorderRadius.all(
                          //     Radius.circular(40.0),
                          //   ),
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
                        style: const TextStyle(fontSize: 40.0, color: kTextInputColor),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          labelText: "Supplier Name :",
                          labelStyle: kSupplierTextFormFieldText,
                          fillColor:textFieldfillColor,
                          filled: true,
                          enabledBorder: kEnabledBorder,
                          focusedBorder: kFocusedBorder,
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
                  submit();
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: const Text(
                  'SUBMIT',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
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
