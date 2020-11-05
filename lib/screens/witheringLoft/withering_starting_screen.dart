import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_starting_finishing.dart';
import 'package:teatrackerappofficer/providers/withering/withering_starting__finishing_provider.dart';

class WitheringStartScreen extends StatefulWidget {
  @override
  _WitheringStartScreenState createState() => _WitheringStartScreenState();
}

class _WitheringStartScreenState extends State<WitheringStartScreen> {
  final _formKeyWitheringStarting = GlobalKey<FormState>();
  var _witheringStarting = WitheringStartingFinishing(
      id: null,
      troughNumber: null,
      time: null,
      temperature: null,
      humidity: null);

  Future<void> _saveWitheringStartingProviderDetails() async {
    final authToken = Provider.of<Auth>(context, listen: false).token;

    final isValid = _formKeyWitheringStarting.currentState.validate();

    if (!isValid) {
      return;
    }

    _formKeyWitheringStarting.currentState.save();
    try {
      await Provider.of<WitheringStartingFinishingProvider>(context,
              listen: false)
          .addWitheringStartingItem(_witheringStarting, authToken);

      Navigator.of(context).pushNamed('WitheringStartingView');
    } catch (e) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AlertDialog(
                title: const Text('Warning !'),
                content: ListBody(
                  children: <Widget>[
                    const Text('Error has occured'),
                    Text(e.toString()),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Okay'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Starting'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveWitheringStartingProviderDetails,
            disabledColor: Colors.white,
            iconSize: 35.0,
          )
        ],
      ),
      body: Form(
        key: _formKeyWitheringStarting,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 300.0),
                child: Container(
                  width: _width * 0.2,
                  height: _height * 0.4,
                  child: Center(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Trough Number : ',
                          errorStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                          contentPadding: const EdgeInsets.all(30.0),
                          border: const OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(50.0)))),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
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
                        _witheringStarting = WitheringStartingFinishing(
                            id: null,
                            troughNumber: int.parse(value),
                            time: null,
                            temperature: _witheringStarting.temperature,
                            humidity: _witheringStarting.humidity);
                      },
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: _width * 0.4,
                    height: _height * 0.4,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Temperature : ',
                          errorStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                          contentPadding: const EdgeInsets.all(30.0),
                          border: const OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(50.0)))),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Temperature !';
                        }
                        if (double.parse(value) <= 20 ||
                            double.parse(value) >= 40) {
                          return 'Please Enter A Valid Temperature !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _witheringStarting = WitheringStartingFinishing(
                            id: null,
                            troughNumber: _witheringStarting.troughNumber,
                            time: null,
                            temperature: double.parse(value),
                            humidity: _witheringStarting.humidity);
                      },
                    ),
                  ),
//                  SizedBox(
//                    width: _width * 0.15,
//                  ),
                  Container(
                    height: _height * 0.4,
                    width: _width * 0.4,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Humidity : ',
                          errorStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                          contentPadding: const EdgeInsets.all(30.0),
                          border: const OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(50.0)))),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Humidity !';
                        }
                        if (double.parse(value) <= 50 ||
                            double.parse(value) >= 90) {
                          return 'Please Enter A Valid Humidity !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _witheringStarting = WitheringStartingFinishing(
                            id: null,
                            troughNumber: _witheringStarting.troughNumber,
                            time: DateTime.now(),
                            temperature: _witheringStarting.temperature,
                            humidity: double.parse(value));
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
