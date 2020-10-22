import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering_starting__finishing_provider.dart';
import 'package:teatrackerappofficer/providers/withering_starting_finishing.dart';

class WitheringFinishingScreen extends StatefulWidget {
  @override
  _WitheringFinishingScreenState createState() => _WitheringFinishingScreenState();
}

class _WitheringFinishingScreenState extends State<WitheringFinishingScreen> {
  final _formKeyWitheringFinishing = GlobalKey<FormState>();
  var _witheringFinishing = WitheringStartingFinishing(
      id: null,
      troughNumber: null,
      time: null,
      temperature: null,
      humidity: null);

  void _saveWitheringFinishingProviderDetails() {
    final isValid = _formKeyWitheringFinishing.currentState.validate();

    if (!isValid) {
      return;
    }

    _formKeyWitheringFinishing.currentState.save();

    Provider.of<WitheringStartingFinishingProvider>(context, listen: false)
        .addWitheringFinishingItem(_witheringFinishing);

    Navigator.of(context).pushNamed('WitheringFinishingView');
  }

  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Withering Finishing'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveWitheringFinishingProviderDetails,
            disabledColor: Colors.white,
            iconSize: 35.0,
          )
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKeyWitheringFinishing,
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
                        _witheringFinishing = WitheringStartingFinishing(
                            id: null,
                            troughNumber: int.parse(value),
                            time: null,
                            temperature: _witheringFinishing.temperature,
                            humidity: _witheringFinishing.humidity);
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
                        _witheringFinishing = WitheringStartingFinishing(
                            id: null,
                            troughNumber: _witheringFinishing.troughNumber,
                            time: null,
                            temperature: double.parse(value),
                            humidity: _witheringFinishing.humidity);
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
                        _witheringFinishing = WitheringStartingFinishing(
                            id: null,
                            troughNumber: _witheringFinishing.troughNumber,
                            time: DateTime.now(),
                            temperature: _witheringFinishing.temperature,
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
