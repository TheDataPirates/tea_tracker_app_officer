import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/rolling/drying.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';

import '../../constants.dart';

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
      drierOutWeight: null,
      outturn: null);

  Future<void> _saveDryingProviderDetails() async{
    final isValid = _formKeyDrying.currentState.validate();
    final authToken = Provider.of<Auth>(context, listen: false).token;

    if (!isValid) {
      return;
    }

    if (!(Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
            listen: false)
        .isBatchMade(int.parse(_batchNum.text), DateTime.now()))) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                'You have not created batch ' + '${int.parse(_batchNum.text)}'),
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
    } else if (_dhoolNum.text != 'BB') {
//      print('Enter != BB');
      if (!(Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
              listen: false)
          .isFermentedDhoolMade(int.parse(_batchNum.text),
              int.parse(_dhoolNum.text), DateTime.now()))) {
//        print('Enter != BB and isDhoolMade NO');
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('You have not created fermented dhool ' +
                  '${int.parse(_dhoolNum.text)}'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const Text(
                        'Please enter a different fermented dhool number !'),
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
      } else if (Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
              listen: false)
          .isDryedDhoolMade(int.parse(_batchNum.text),
              int.parse(_dhoolNum.text), DateTime.now())) {
//        print('Enter isFermentedDhoolMade');
//        print('entered fd num : ' + '${int.parse(_dhoolNum.text)}');
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('You have already created dryed dhool ' +
                  '${int.parse(_dhoolNum.text)}'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const Text('Please enter a different dryed dhool number !'),
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
      } else {
//        _formKeyDrying.currentState.save();
//
//        Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
//                listen: false)
//            .addDryingItem(_drying);
//
//        Navigator.of(context).pushNamed('DrierOutputView');

        try {
          _formKeyDrying.currentState.save();

          await Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
              listen: false)
              .addDryingItem(_drying, authToken);

          Navigator.of(context).pushNamed('DrierOutputView');
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
    } else if (_dhoolNum.text == 'BB') {
//      print('Enter == BB');
      if (!(Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
              listen: false)
          .isFermentedBigBulkMade(
              int.parse(_batchNum.text), _dhoolNum.text, DateTime.now()))) {
//        print('Enter == BB and isDhoolMade NO');
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                  'You have not created fermented dhool ' + _dhoolNum.text),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const Text(
                        'Please enter a different fermented dhool number !'),
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
      } else if (Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
              listen: false)
          .isDryedBigBulkMade(
              int.parse(_batchNum.text), _dhoolNum.text, DateTime.now())) {
//        print('Enter isFermentedDhoolMade');
//        print('entered fd num : ' + _dhoolNum.text);
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                  'You have already created dryed dhool ' + _dhoolNum.text),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const Text('Please enter a different dryed dhool number !'),
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
      } else {
//        _formKeyDrying.currentState.save();
//
//        Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
//                listen: false)
//            .addDryingItem(_drying);
//
//        Navigator.of(context).pushNamed('DrierOutputView');

        try {
          _formKeyDrying.currentState.save();

          await Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
              listen: false)
              .addDryingItem(_drying, authToken);

          Navigator.of(context).pushNamed('DrierOutputView');
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
    } else {
//      _formKeyDrying.currentState.save();
//
//      Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
//              listen: false)
//          .addDryingItem(_drying);
//
//      Navigator.of(context).pushNamed('DrierOutputView');
      try {
        _formKeyDrying.currentState.save();

//        print("Outturn in the input screen");
//        print(_drying.outturn);

        await Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
            listen: false)
            .addDryingItem(_drying, authToken);

        Navigator.of(context).pushNamed('DrierOutputView');
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
  }

  final _batchNum = TextEditingController();
  final _dhoolNum = TextEditingController();

  void dispose() {
    _batchNum.dispose();
    _dhoolNum.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final drying =
        Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false);

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
      body: Container(
        decoration: BoxDecoration(
          gradient: kUIGradient,
        ),
        child: SafeArea(
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
                        controller: _batchNum,
                        decoration: const InputDecoration(
                          labelText: 'Batch Number : ',
                          labelStyle: kTextFormFieldLabelStyle,
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
                          enabledBorder: kEnabledBorder,
                          focusedBorder: kFocusedBorder,
                          focusedErrorBorder: kFocusedErrorBorder,
                          errorBorder: kErrorBorder,
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color:kTextInputColor,
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
                            outturn: _drying.outturn,
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
                        controller: _dhoolNum,
                        decoration: const InputDecoration(
                          labelText: 'Dhool Number : ',
                          labelStyle: kTextFormFieldLabelStyle,
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
                          enabledBorder: kEnabledBorder,
                          focusedBorder: kFocusedBorder,
                          focusedErrorBorder: kFocusedErrorBorder,
                          errorBorder: kErrorBorder,
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color:kTextInputColor,
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
                            outturn: _drying.outturn,
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
                          labelStyle: kTextFormFieldLabelStyle,
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
                          enabledBorder: kEnabledBorder,
                          focusedBorder: kFocusedBorder,
                          focusedErrorBorder: kFocusedErrorBorder,
                          errorBorder: kErrorBorder,
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color:kTextInputColor,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Drier Out Weight !';
                          }
                          if (int.parse(value) <= 0 ||
                              int.parse(value) >= 101) {
                            return 'Please Enter A Valid Drier Out Weight !';
                          }
                          return null;
                        },
                        onSaved: (value) {
//                          print("Batch number in drier");
//                          print(int.parse(_batchNum.text));
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
                            outturn: drying.batchOutturnWithDrierWeight(int.parse(_batchNum.text), DateTime.now(), double.parse(value)),
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
      ),
    );
  }
}
