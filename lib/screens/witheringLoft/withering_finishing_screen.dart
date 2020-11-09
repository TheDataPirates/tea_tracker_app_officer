import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_starting__finishing_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_starting_finishing.dart';

class WitheringFinishingScreen extends StatefulWidget {
  @override
  _WitheringFinishingScreenState createState() =>
      _WitheringFinishingScreenState();
}

class _WitheringFinishingScreenState extends State<WitheringFinishingScreen> {
  final _formKeyWitheringFinishing = GlobalKey<FormState>();
  var _witheringFinishing = WitheringStartingFinishing(
      id: null,
      troughNumber: null,
      time: null,
      temperature: null,
      humidity: null);

  Future<void> _saveWitheringFinishingProviderDetails() async {
    final authToken = Provider.of<Auth>(context, listen: false).token;
    final isValid = _formKeyWitheringFinishing.currentState.validate();

    if (!isValid) {
      return;
    }

    if(Provider.of<WitheringStartingFinishingProvider>(context, listen: false).isTroughFinished(int.parse(_troughNum.text), DateTime.now())){
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You have already finished trough ' + '${int.parse(_troughNum.text)}'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text('Please enter a different trough number !'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                  return;
                },
              ),
            ],
          );
        },
      );
    }else{
      _formKeyWitheringFinishing.currentState.save();
      try {
        await Provider.of<WitheringStartingFinishingProvider>(context,
            listen: false)
            .addWitheringFinishingItem(_witheringFinishing, authToken);

        Navigator.of(context).pushNamed('WitheringFinishingView');
      } catch (error) {
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
                      Text(error.toString()),
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
  }

  final _troughNum = TextEditingController();

  void dispose() {
    _troughNum.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Finishing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
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
                      controller: _troughNum,
                      decoration: const InputDecoration(
                        labelText: 'Trough Number : ',
                        errorStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                        contentPadding: const EdgeInsets.all(30.0),
                        border: const OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
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
                      decoration: const InputDecoration(
                        labelText: 'Temperature : ',
                        errorStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                        contentPadding: const EdgeInsets.all(30.0),
                        border: const OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
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
                      decoration: const InputDecoration(
                        labelText: 'Humidity : ',
                        errorStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                        contentPadding: const EdgeInsets.all(30.0),
                        border: const OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                      ),
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
