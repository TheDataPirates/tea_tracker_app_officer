import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/rolling/fermenting.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';

class FermentingRoomScreen extends StatefulWidget {
  @override
  _FermentingRoomScreenState createState() => _FermentingRoomScreenState();
}

class _FermentingRoomScreenState extends State<FermentingRoomScreen> {
  final _formKeyFermenting = GlobalKey<FormState>();
  var _fermenting = Fermenting(
    id: null,
    batchNumber: null,
    dhoolNumber: null,
    time: null,
    dhoolInWeight: null,
    dhoolOutWeight: null,
  );

  Future<void> _saveFermentingProviderDetails() async {
    final authToken = Provider.of<Auth>(context, listen: false).token;
    final isValid = _formKeyFermenting.currentState.validate();

    if (!isValid) {
      return;
    }
    try {
      _formKeyFermenting.currentState.save();

      await Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
              listen: false)
          .addFermentingItem(_fermenting, authToken);

      Navigator.of(context).pushNamed('FermentingView');
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
    final fermenting =
        Provider.of<WitheringLoadingUnloadingRollingProvider>(context);

    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fermenting Room'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
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
                      decoration: const InputDecoration(
                        labelText: 'Batch Number : ',
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
                      decoration: const InputDecoration(
                        labelText: 'Dhool Number : ',
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
                          return 'Please Enter Dhool Number !';
                        }
                        if ((value != 'BB') &&
                            (value != 'bb') &&
                            (int.parse(value) != 1) &&
                            (int.parse(value) != 2 &&
                                (int.parse(value) != 3) &&
                                (int.parse(value) != 4) &&
                                (int.parse(value) != 5))) {
                          return 'Please Enter A Valid Dhool Number !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _fermenting = Fermenting(
                          id: null,
                          batchNumber: _fermenting.batchNumber,
                          dhoolNumber: value,
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
                      decoration: const InputDecoration(
                        labelText: 'Dhool Out Weight : ',
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
                          return 'Please Enter Dhool Out Weight !';
                        }
                        if (int.parse(value) <= 0 || int.parse(value) >= 300) {
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
                          dhoolInWeight: fermenting.dhoolInputWeight(
                              _fermenting.batchNumber,
                              DateTime.now(),
                              _fermenting
                                  .dhoolNumber), //In here have to build a method to return the dhool input weight
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
