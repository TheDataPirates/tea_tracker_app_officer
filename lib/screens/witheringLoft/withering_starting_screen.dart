import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering_starting.dart';
import 'package:teatrackerappofficer/providers/withering_starting_provider.dart';

class WitheringStartScreen extends StatefulWidget {
  @override
  _WitheringStartScreenState createState() => _WitheringStartScreenState();
}

class _WitheringStartScreenState extends State<WitheringStartScreen> {

  final _formKeyWitheringStarting = GlobalKey<FormState>();
  var _witheringStarting = WitheringStarting(
      id: null, troughNumber: null, time: null, temperature: null, humidity: null);

  void _saveWitheringMixingProviderDetails() {
    final isValid = _formKeyWitheringStarting.currentState.validate();

    if (!isValid) {
      return;
    }

    _formKeyWitheringStarting.currentState.save();

    Provider.of<WitheringStartingProvider>(context, listen: false)
        .addWitheringStartingItem(_witheringStarting);

    Navigator.of(context).pushNamed('WitheringStartingView');
  }

  @override
  Widget build(BuildContext context) {

    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Withering Starting'),
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
          key: _formKeyWitheringStarting,
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
                        _witheringStarting = WitheringStarting(
                            id: null,
                            troughNumber: int.parse(value),
                            time: null,
                            temperature: _witheringStarting.temperature,
                            humidity: _witheringStarting.humidity);
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
                        _witheringStarting = WitheringStarting(
                            id: null,
                            troughNumber: _witheringStarting.troughNumber,
                            time: null,
                            temperature: double.parse(value),
                            humidity: _witheringStarting.humidity);
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
                        _witheringStarting = WitheringStarting(
                            id: null,
                            troughNumber: _witheringStarting.troughNumber,
                            time: DateTime.now(),
                            temperature: _witheringStarting.temperature,
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
