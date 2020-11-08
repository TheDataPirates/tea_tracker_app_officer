import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/rolling/rolling.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/main_menu_button_container.dart';

class RollingRoomScreen extends StatefulWidget {
  @override
  _RollingRoomScreenState createState() => _RollingRoomScreenState();
}

class _RollingRoomScreenState extends State<RollingRoomScreen> {

  final _formKeyRollingOutput = GlobalKey<FormState>();

  var _rollingOutput = Rolling(
      id: null,
      batchNumber: null,
      rollingTurn: null,
      time: null,
      rollerNumber: null,
      weightIn: null,
  weightOut: null,);

  void _saveRollingOutputProviderDetails(int batchN, int rollingT) {
    final isValid = _formKeyRollingOutput.currentState.validate();

    if (!isValid) {
      return;
    }

    if(Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false).isBatchRollingTurnAlreadyUsed(batchN, rollingT, DateTime.now())){
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You have already used rolling turn ' + '$rollingT' + ' on batch ' + '$batchN'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text('Please enter a different rolling turn !'),
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
    }else if (Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false).isBatchEnded(batchN, DateTime.now())){
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You have already ended batch ' + '$batchN'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text('Please try a different batch number !'),
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
    }else if(!(Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false).isBatchMade(batchN, DateTime.now()))){
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You have not created batch ' + '$batchN'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text('Please enter a different batch number !'),
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
    }
    else{
      _formKeyRollingOutput.currentState.save();

      Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
          listen: false)
          .addRollingOutputItem(_rollingOutput);

      Navigator.of(context).pushNamed('RollingOutputView');
    }

  }

  final _batchNum = TextEditingController();
  final _rollingTurn = TextEditingController();


  void dispose() {
    _batchNum.dispose();
    _rollingTurn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final _rollingProvider =
    Provider.of<WitheringLoadingUnloadingRollingProvider>(context);

    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rolling Output'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: (){
              _saveRollingOutputProviderDetails(int.parse(_batchNum.text), int.parse(_rollingTurn.text));
            },
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
                      controller: _batchNum,
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
                        _rollingOutput = Rolling(
                          id: null,
                          batchNumber: int.parse(value),
                          rollingTurn: _rollingOutput.rollingTurn,
                          time: null,
                          rollerNumber: _rollingOutput.rollerNumber,
                          weightIn: null,
                          weightOut: _rollingOutput.weightOut,
                        );
                      },
                    ),
                  ),
                  Container(
                    height: _height * 0.2,
                    width: _width * 0.4,
                    child: TextFormField(
                      controller: _rollingTurn,
                      decoration: const InputDecoration(
                        labelText: 'Rolling Turn : ',
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
                          weightIn: null,
                          weightOut: _rollingOutput.weightOut,
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
                        labelText: 'Roller Number : ',
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
                          weightIn: null,
                          weightOut: _rollingOutput.weightOut, //In here need to create a method that will return the weight of the batch.
                        );
                      },
                    ),
                  ),
                  Container(
                    height: _height * 0.2,
                    width: _width * 0.4,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Roller Output Weight : ',
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
                          return 'Please Enter Roller Output Weight !';
                        }
                        if (int.parse(value) <= 0 || int.parse(value) >= 351) {
                          return 'Please Enter A Valid Roller Output Weight !';
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
                          weightIn: _rollingProvider.batchWeight(
                              _rollingOutput.batchNumber,
                              DateTime.now(),
                              _rollingOutput
                                  .rollingTurn),
                          weightOut: double.parse(value), //In here need to create a method that will return the weight of the batch.
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
