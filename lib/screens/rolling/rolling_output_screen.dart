import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/rolling/rolling.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';

class RollingOutputScreen extends StatefulWidget {
  @override
  _RollingOutputScreenState createState() => _RollingOutputScreenState();
}

class _RollingOutputScreenState extends State<RollingOutputScreen> {

  final _formKeyRollingOutput = GlobalKey<FormState>();
  var _rollingOutput = Rolling(
      id: null, batchNumber: null, rollingTurn: null, time: null, rollerNumber: null, weight: null);

  void _saveRollingOutputProviderDetails() {
    final isValid = _formKeyRollingOutput.currentState.validate();

    if (!isValid) {
      return;
    }

    _formKeyRollingOutput.currentState.save();

    Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false)
        .addRollingOutputItem(_rollingOutput);

    Navigator.of(context).pushNamed('RollingOutputView');
  }

  @override
  Widget build(BuildContext context) {

    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Rolling Output'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveRollingOutputProviderDetails,
            disabledColor: Colors.white,
            iconSize: 35.0,
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKeyRollingOutput,
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
                        _rollingOutput = Rolling(
                          id: null,
                          batchNumber: int.parse(value),
                          rollingTurn: _rollingOutput.rollingTurn,
                          time: null,
                          rollerNumber: _rollingOutput.rollerNumber,
                          weight: _rollingOutput.weight,
                        );
                      },
                    ),
                  ),
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
                        _rollingOutput = Rolling(
                          id: null,
                          batchNumber: _rollingOutput.batchNumber,
                          rollingTurn: int.parse(value),
                          time: null,
                          rollerNumber: _rollingOutput.rollerNumber,
                          weight: _rollingOutput.weight,
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
                        _rollingOutput = Rolling(
                          id: null,
                          batchNumber: _rollingOutput.batchNumber,
                          rollingTurn: _rollingOutput.rollingTurn,
                          time: DateTime.now(),
                          rollerNumber: int.parse(value),
                          weight: _rollingOutput.weight,
                        );
                      },
                    ),
                  ),
                  Container(
                    height: _height * 0.2,
                    width: _width * 0.4,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Weight : ',
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
                          return 'Please Enter Weight !';
                        }
                        if (int.parse(value) <= 0 || int.parse(value) >= 351) {
                          return 'Please Enter A Valid Weight !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _rollingOutput = Rolling(
                          id: null,
                          batchNumber: _rollingOutput.batchNumber,
                          rollingTurn: _rollingOutput.rollingTurn,
                          time: DateTime.now(),
                          rollerNumber: _rollingOutput.rollerNumber,
                          weight: double.parse(value),
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
