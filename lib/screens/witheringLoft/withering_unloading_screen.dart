import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_unloading.dart';
import 'package:teatrackerappofficer/constants.dart';

class WitheringUnloadingScreen extends StatefulWidget {
  @override
  _WitheringUnloadingScreenState createState() =>
      _WitheringUnloadingScreenState();
}

class _WitheringUnloadingScreenState extends State<WitheringUnloadingScreen> {
  final _formKeyWitheringUnloading = GlobalKey<FormState>();

  var _witheringUnloading = WitheringUnloading(
    id: null,
    batchNumber: null,
    troughNumber: null,
    boxNumber: null,
    date: null,
    lotWeight: null,
    witheringPct: null,
  );

  Future<void> _saveWitheringUnloadingProviderDetails() async {
    final isValid = _formKeyWitheringUnloading.currentState.validate();
    final authToken = Provider.of<Auth>(context, listen: false).token;

    if (!isValid) {
      return;
    }

    if (Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
            listen: false)
        .isTroughBoxUsed(int.parse(_troughNum.text), int.parse(_boxNum.text),
            DateTime.now())) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black87,
            title: Text(
              'You have already entered trough ' +
                  '${int.parse(_troughNum.text)}' +
                  ' and box ' +
                  '${int.parse(_boxNum.text)}',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text(
                    'Please enter a different box in a trough !',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'OK',
                  style: TextStyle(fontSize: 17),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  return;
                },
              ),
            ],
          );
        },
      );
    } else if (!(Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
            listen: false)
        .isTroughBoxLoaded(int.parse(_troughNum.text), int.parse(_boxNum.text),
            DateTime.now()))) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black87,
            title: Text(
              'You have not loaded trough ' +
                  '${int.parse(_troughNum.text)}' +
                  ' box ' +
                  '${int.parse(_boxNum.text)}',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text(
                    'Please enter a loaded box in a trough !',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'OK',
                  style: TextStyle(fontSize: 17),
                ),
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
      try {
        _formKeyWitheringUnloading.currentState.save();

        await Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
                listen: false)
            .addWitheringUnloadingItem(_witheringUnloading, authToken);

        Navigator.of(context).pushNamed('WitheringUnloadingView');
      } catch (e) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: AlertDialog(
                  title: const Text(
                    'Warning !',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  backgroundColor: Colors.black87,
                  content: ListBody(
                    children: <Widget>[
                      const Text(
                        'Error has occured',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Text(
                        e.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        'Okay',
                        style: TextStyle(fontSize: 17),
                      ),
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
  final _boxNum = TextEditingController();

  void dispose() {
    _troughNum.dispose();
    _boxNum.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final witheringUnloadingBatchNumber =
        Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
            listen: false);

    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Unloading'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              _saveWitheringUnloadingProviderDetails();
            },
            disabledColor: Colors.white,
            iconSize: 35.0,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: inputScreenBackgroundImage,
          gradient: kUIGradient,
        ),
        child: SafeArea(
          child: Form(
            key: _formKeyWitheringUnloading,
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
                        decoration: InputDecoration(
                          labelText: 'Trough Number : ',
                          labelStyle: kTextFormFieldLabelStyle,
                          fillColor: textFieldfillColor,
                          filled: true,
                          errorStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                          contentPadding: const EdgeInsets.all(30.0),
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
                            color: kTextInputColor),
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
                          _witheringUnloading = WitheringUnloading(
                            id: null,
                            batchNumber: null,
                            troughNumber: int.parse(value),
                            date: null,
                            boxNumber: _witheringUnloading.boxNumber,
                            lotWeight: _witheringUnloading.lotWeight,
                            witheringPct: _witheringUnloading.witheringPct,
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
                        controller: _boxNum,
                        decoration: InputDecoration(
                          labelText: 'Box Number : ',
                          labelStyle: kTextFormFieldLabelStyle,
                          fillColor: textFieldfillColor,
                          filled: true,
                          errorStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                          contentPadding: const EdgeInsets.all(30.0),
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
                            color: kTextInputColor),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Box Number !';
                          }
                          if (double.parse(value) <= 0 ||
                              double.parse(value) >= 11) {
                            return 'Please Enter A Valid Box Number !';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _witheringUnloading = WitheringUnloading(
                            id: null,
                            batchNumber: null,
                            troughNumber: _witheringUnloading.troughNumber,
                            date: null,
                            boxNumber: int.parse(value),
                            lotWeight: _witheringUnloading.lotWeight,
                            witheringPct: _witheringUnloading.witheringPct,
                          );
                        },
                      ),
                    ),
                    Container(
                      height: _height * 0.2,
                      width: _width * 0.4,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Lot Weight : ',
                          labelStyle: kTextFormFieldLabelStyle,
                          fillColor: textFieldfillColor,
                          filled: true,
                          errorStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                          contentPadding: const EdgeInsets.all(30.0),
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
                            color: kTextInputColor),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Lot Weight !';
                          }
                          if (double.parse(value) <= 0 ||
                              double.parse(value) >= 351) {
                            return 'Please Enter A Valid Lot Weight !';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _witheringUnloading = WitheringUnloading(
                            id: null,
                            batchNumber: witheringUnloadingBatchNumber
                                .lastBatchNumberItem,
                            troughNumber: _witheringUnloading.troughNumber,
                            date: DateTime.now(),
                            boxNumber: _witheringUnloading.boxNumber,
                            lotWeight: double.parse(value),
                            witheringPct: witheringUnloadingBatchNumber
                                .witheringTroughBoxDatePercentage(
                                    troughNumber: int.parse(_troughNum.text),
                                    lotWeight: double.parse(value),
                                    date: DateTime.now(),
                                    boxNumber: int.parse(_boxNum.text)),
                          );
                        },
                      ),
                    )
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
