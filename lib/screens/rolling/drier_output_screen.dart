import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/rolling/drying.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';

class DrierOutputScreen extends StatefulWidget {
  @override
  _DrierOutputScreenState createState() => _DrierOutputScreenState();
}

class _DrierOutputScreenState extends State<DrierOutputScreen> {
  final _formKeyDrying = GlobalKey<FormState>();
  var _drying = Drying(
      id: null,
      batchNumber: null,
      dhoolNumber: null,
      time: null,
      drierInWeight: null,
      drierOutWeight: null);

  void _saveDryingProviderDetails() {
    final isValid = _formKeyDrying.currentState.validate();

    if (!isValid) {
      return;
    }

    _formKeyDrying.currentState.save();

    Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
            listen: false)
        .addDryingItem(_drying);

    Navigator.of(context).pushNamed('DrierOutputView');
  }

  @override
  Widget build(BuildContext context) {
    final drying =
        Provider.of<WitheringLoadingUnloadingRollingProvider>(context);

    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drier Output'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveDryingProviderDetails,
            disabledColor: Colors.white,
            iconSize: 35.0,
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKeyDrying,
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
                        _drying = Drying(
                          id: null,
                          batchNumber: int.parse(value),
                          dhoolNumber: _drying.dhoolNumber,
                          time: null,
                          drierInWeight: null,
                          drierOutWeight: _drying.drierOutWeight,
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
                        _drying = Drying(
                          id: null,
                          batchNumber: _drying.batchNumber,
                          dhoolNumber: value,
                          time: null,
                          drierInWeight: null,
                          drierOutWeight: _drying.drierOutWeight,
                        );
                      },
                    ),
                  ),
                  Container(
                    height: _height * 0.2,
                    width: _width * 0.4,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Drier Out Weight : ',
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
                          return 'Please Enter Drier Out Weight !';
                        }
                        if (int.parse(value) <= 0 || int.parse(value) >= 101) {
                          return 'Please Enter A Valid Drier Out Weight !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _drying = Drying(
                          id: null,
                          batchNumber: _drying.batchNumber,
                          dhoolNumber: _drying.dhoolNumber,
                          time: DateTime.now(),
                          drierInWeight: drying.drierInputWeight(
                              _drying.batchNumber,
                              DateTime.now(),
                              _drying
                                  .dhoolNumber), //In here have to build a method to return the drier input weight
                          drierOutWeight: double.parse(value),
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