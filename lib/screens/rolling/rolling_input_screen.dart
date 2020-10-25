import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/rolling/rolling.dart';
import 'package:teatrackerappofficer/providers/rolling/rolling_provider.dart';

class RollingInputScreen extends StatefulWidget {
  @override
  _RollingInputScreenState createState() => _RollingInputScreenState();
}

class _RollingInputScreenState extends State<RollingInputScreen> {

  final _formKeyRollingInput = GlobalKey<FormState>();
  var _rollingInput = Rolling(
      id: null, batchNumber: null, rollingTurn: null, time: null, rollerNumber: null, weight: null);

  void _saveRollingInputProviderDetails() {
    final isValid = _formKeyRollingInput.currentState.validate();

    if (!isValid) {
      return;
    }

    _formKeyRollingInput.currentState.save();

    Provider.of<RollingProvider>(context, listen: false)
        .addRollingInputItem(_rollingInput);

    Navigator.of(context).pushNamed('RollingInputView');
  }

  @override
  Widget build(BuildContext context) {

    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Rolling Input'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveRollingInputProviderDetails,
            disabledColor: Colors.white,
            iconSize: 35.0,
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKeyRollingInput,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: _height * 0.2,
                    width: _width * 0.4,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Batch Number : ',
                          errorStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                          contentPadding: EdgeInsets.all(30.0),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50.0)))),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Batch Number !';
                        }
                        if (int.parse(value) >= 31 || int.parse(value) <= 0) {
                          return 'Please Enter A Valid Batch Number !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _rollingInput = Rolling(
                            id: null,
                            batchNumber: int.parse(value),
                            rollingTurn: _rollingInput.rollingTurn,
                            time: null,
                            rollerNumber: _rollingInput.rollerNumber,
                            weight: null,
                        );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: _height * 0.2,
                    width: _width * 0.4,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Rolling Turn : ',
                          errorStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                          contentPadding: EdgeInsets.all(30.0),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50.0)))),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Rolling Turn !';
                        }
                        if (int.parse(value) >= 6 || int.parse(value) <= 0) {
                          return 'Please Enter A Valid Rolling Turn !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _rollingInput = Rolling(
                          id: null,
                          batchNumber: _rollingInput.batchNumber,
                          rollingTurn: int.parse(value),
                          time: null,
                          rollerNumber: _rollingInput.rollerNumber,
                          weight: null,
                        );
                      },
                    ),
                  ),
                  Container(
                    height: _height * 0.2,
                    width: _width * 0.4,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Roller Number : ',
                          errorStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                          contentPadding: EdgeInsets.all(30.0),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50.0)))),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Roller Number !';
                        }
                        if (int.parse(value) <= 0 || int.parse(value) >= 5) {
                          return 'Please Enter A Valid Roller Number !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _rollingInput = Rolling(
                          id: null,
                          batchNumber: _rollingInput.batchNumber,
                          rollingTurn: _rollingInput.rollingTurn,
                          time: DateTime.now(),
                          rollerNumber: int.parse(value),
                          weight: null,//In here need to create a method that will return the weight of the batch.
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
