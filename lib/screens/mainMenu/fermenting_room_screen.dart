import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/rolling/fermenting.dart';
import 'package:teatrackerappofficer/providers/rolling/rolling_provider.dart';

class FermentingRoomScreen extends StatefulWidget {
  @override
  _FermentingRoomScreenState createState() => _FermentingRoomScreenState();
}

class _FermentingRoomScreenState extends State<FermentingRoomScreen> {

  final _formKeyFermenting = GlobalKey<FormState>();
  var _fermenting = Fermenting(
      id: null, batchNumber: null, dhoolNumber: null, time: null, dhoolInWeight: null, dhoolOutWeight: null);

  void _saveFermentingProviderDetails() {
    final isValid = _formKeyFermenting.currentState.validate();

    if (!isValid) {
      return;
    }

    _formKeyFermenting.currentState.save();

    Provider.of<RollingProvider>(context, listen: false)
        .addFermentingItem(_fermenting);

    Navigator.of(context).pushNamed('FermentingView');
  }

  @override
  Widget build(BuildContext context) {

    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Fermenting Room'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveFermentingProviderDetails,
            disabledColor: Colors.white,
            iconSize: 35.0,
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKeyFermenting,
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
                        _fermenting = Fermenting(
                          id: null,
                          batchNumber: int.parse(value),
                          dhoolNumber: _fermenting.dhoolNumber,
                          time: null,
                          dhoolInWeight: null,
                          dhoolOutWeight: _fermenting.dhoolOutWeight,
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
                          labelText: 'Dhool Number : ',
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
                          return 'Please Enter Dhool Number !';
                        }
                        if (int.parse(value) <= 0 || int.parse(value) >= 6) {
                          return 'Please Enter A Valid Dhool Number !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _fermenting = Fermenting(
                          id: null,
                          batchNumber: _fermenting.batchNumber,
                          dhoolNumber: int.parse(value),
                          time: null,
                          dhoolInWeight: null,
                          dhoolOutWeight: _fermenting.dhoolOutWeight,
                        );
                      },
                    ),
                  ),
                  Container(
                    height: _height * 0.2,
                    width: _width * 0.4,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Dhool Out Weight : ',
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
                          return 'Please Enter Dhool Out Weight !';
                        }
                        if (int.parse(value) <= 0 || int.parse(value) >= 351) {
                          return 'Please Enter A Valid Dhool Out Weight !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _fermenting = Fermenting(
                          id: null,
                          batchNumber: _fermenting.batchNumber,
                          dhoolNumber: _fermenting.dhoolNumber,
                          time: DateTime.now(),
                          dhoolInWeight: null,//In here have to build a method to return the dhool input weight
                          dhoolOutWeight: double.parse(value),
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
