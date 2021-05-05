import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/bought_leaf/tea_collections_provider.dart';
import '../bought_leaf/lot_list_screen.dart';
import 'package:teatrackerappofficer/constants.dart';

class BoughtLeafScreen extends StatefulWidget {
  @override
  _BoughtLeafScreenState createState() => _BoughtLeafScreenState();
}

class _BoughtLeafScreenState extends State<BoughtLeafScreen> {
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
            title: const Text('AlertDialog',style: TextStyle(color: Colors.white, fontSize: 18),),
            backgroundColor: Colors.black87,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text('No supplier id or name entered',style: TextStyle(color: Colors.white, fontSize: 17),),
                  const Text('Please Enter again',style: TextStyle(color: Colors.white, fontSize: 17),),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text("OK",style: TextStyle(fontSize: 17),),
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
            .verifySupplier(
            supplierNoEditingController.text,
            supplierNameEditingController.text,
            token,
            user,
            "OfficerOriginal");
        print('bulk saved');
        Navigator.of(context).pushNamed('InputCollectionScreen');
      } catch (error) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('AlertDialog',style: TextStyle(color: Colors.white, fontSize: 18),),
              backgroundColor: Colors.black87,
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('An error occurred', style: TextStyle(color: Colors.white, fontSize: 17),),
                    Text(error.toString(),style: TextStyle(color: Colors.white, fontSize: 17),),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK", style: TextStyle(fontSize: 17),),
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
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body:Container(
          decoration: BoxDecoration(
            image : inputScreenBackgroundImage,
            gradient: kUIGradient,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: _height * 0.3, horizontal: _width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: _width * 0.5,
                          child: TextField(
                            controller: supplierNoEditingController,
                            obscureText: false,
                            style:  TextStyle(
                                fontSize: _height * 0.06, color: kTextInputColor),
                            decoration: InputDecoration(
                              labelText: "Supplier No :",
                              labelStyle: kSupplierTextFormFieldText,
                              fillColor:textFieldfillColor,
                              filled: true,
                              contentPadding:
                              EdgeInsets.fromLTRB(_width * 0.025, _height * 0.03, _width * 0.025, _height * 0.02),
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
                            style:  TextStyle(
                                fontSize: _height * 0.06, color: kTextInputColor),
                            decoration: InputDecoration(
                              fillColor: textFieldfillColor,
                              filled: true,
                              contentPadding:
                              EdgeInsets.fromLTRB(_width * 0.025, _height * 0.03, _width * 0.025, _height * 0.02),
                              labelText: "Supplier Name :",
                              labelStyle: kSupplierTextFormFieldText,
                              enabledBorder: kEnabledBorder,
                              focusedBorder: kFocusedBorder,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.075,
                child: RaisedButton.icon(
                  onPressed: () {
                    submit();
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: _height * 0.06,
                  ),
                  label: Text(
                    'SUBMIT',
                    style: TextStyle(fontSize: _height * 0.05, color: Colors.white),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  color: const Color(0xff099857),
                ),
              )
            ],
          ),
        )
    );
  }
}