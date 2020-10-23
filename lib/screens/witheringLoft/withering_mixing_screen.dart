import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/providers/withering_mixing.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering_mixing_provider.dart';

class WitheringMixingScreen extends StatefulWidget {
  @override
  _WitheringMixingScreenState createState() => _WitheringMixingScreenState();
}

class _WitheringMixingScreenState extends State<WitheringMixingScreen> {
  final _formKeyWitheringMixing = GlobalKey<FormState>();
  var _witheringMixing = WitheringMixing(
      id: null, troughNumber: null, turn: null, time: null, temperature: null, humidity: null);

  void _saveWitheringMixingProviderDetails() {
    final isValid = _formKeyWitheringMixing.currentState.validate();

    if (!isValid) {
      return;
    }

    _formKeyWitheringMixing.currentState.save();

    Provider.of<WitheringMixingProvider>(context, listen: false)
        .addWitheringMixingItem(_witheringMixing);

    Navigator.of(context).pushNamed('WitheringMixingView');
  }

  @override
  Widget build(BuildContext context) {

    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Withering Mixing'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveWitheringMixingProviderDetails,
            disabledColor: Colors.white,
            iconSize: 35.0,
          )
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKeyWitheringMixing,
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
                          labelText: 'Trough Number : ',
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
                          return 'Please Enter Trough Number !';
                        }
                        if (int.parse(value) >= 6 || int.parse(value) <= 0) {
                          return 'Please Enter A Valid Trough Number !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _witheringMixing = WitheringMixing(
                            id: null,
                            troughNumber: int.parse(value),
                            turn: _witheringMixing.turn,
                            time: null,
                            temperature: _witheringMixing.temperature,
                            humidity: _witheringMixing.humidity);
                      },
                    ),
                  ),
                  Container(
                    height: _height * 0.2,
                    width: _width * 0.4,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Turn : ',
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
                          return 'Please Enter Turn !';
                        }
                        if (int.parse(value) >= 5 || int.parse(value) <= 0) {
                          return 'Please Enter A Valid Turn !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _witheringMixing = WitheringMixing(
                            id: null,
                            troughNumber: _witheringMixing.troughNumber,
                            turn: int.parse(value),
                            time: null,
                            temperature: _witheringMixing.temperature,
                            humidity: _witheringMixing.humidity);
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
                          labelText: 'Temperature : ',
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
                          return 'Please Enter Temperature !';
                        }
                        if (double.parse(value) <= 20 || double.parse(value) >= 40) {
                          return 'Please Enter A Valid Temperature !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _witheringMixing = WitheringMixing(
                            id: null,
                            troughNumber: _witheringMixing.troughNumber,
                            turn: _witheringMixing.turn,
                            time: null,
                            temperature: double.parse(value),
                            humidity: _witheringMixing.humidity);
                      },
                    ),
                  ),
                  Container(
                    height: _height * 0.2,
                    width: _width * 0.4,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Humidity : ',
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
                          return 'Please Enter Humidity !';
                        }
                        if (double.parse(value) <= 50 || double.parse(value) >= 90) {
                          return 'Please Enter A Valid Humidity !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _witheringMixing = WitheringMixing(
                            id: null,
                            troughNumber: _witheringMixing.troughNumber,
                            turn: _witheringMixing.turn,
                            time: DateTime.now(),
                            temperature: _witheringMixing.temperature,
                            humidity: double.parse(value));
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
