import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_mixing.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/constants.dart';

class WitheringMixingScreen extends StatefulWidget {
  @override
  _WitheringMixingScreenState createState() => _WitheringMixingScreenState();
}

class _WitheringMixingScreenState extends State<WitheringMixingScreen> {
  final _formKeyWitheringMixing = GlobalKey<FormState>();
  var _witheringMixing = WitheringMixing(
      id: null,
      troughNumber: null,
      turn: null,
      time: null,
      temperature: null,
      humidity: null);

  Future<void> _saveWitheringMixingProviderDetails() async {
    final authToken = Provider.of<Auth>(context, listen: false).token;
    final isValid = _formKeyWitheringMixing.currentState.validate();

    if (!isValid) {
      return;
    }

    if(Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false).isBatchMixingTurnUsed(int.parse(_troughNum.text), int.parse(_turn.text), DateTime.now())){
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You have already entered turn ' + '${int.parse(_turn.text)}' + ' in trough ' + '${int.parse(_troughNum.text)}'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text('Please enter different turn !'),
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
    }else if(!(Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false).isTroughStarted(int.parse(_troughNum.text), DateTime.now()))){
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You have not started trough ' + '${int.parse(_troughNum.text)}'),
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
      _formKeyWitheringMixing.currentState.save();
      try {
        await Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false)
            .addWitheringMixingItem(_witheringMixing, authToken);

        Navigator.of(context).pushNamed('WitheringMixingView');
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

  final _troughNum = TextEditingController();
  final _turn = TextEditingController();

  void dispose() {
    _troughNum.dispose();
    _turn.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Mixing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveWitheringMixingProviderDetails,
            disabledColor: Colors.white,
            iconSize: 35.0,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image : inputScreenBackgroundImage,
//            gradient: kUIGradient,
        ),
        child: SafeArea(
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
                        controller: _troughNum,
                        decoration: const InputDecoration(
                          labelText: 'Trough Number : ',
                          labelStyle: kTextFormFieldLabelStyle,
                          errorStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
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
                            color:kTextInputColor,

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
                        controller: _turn,
                        decoration: const InputDecoration(
                          labelText: 'Turn : ',
                          labelStyle: kTextFormFieldLabelStyle,
                          errorStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
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
                            color:kTextInputColor,
                        ),
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
                        decoration: const InputDecoration(
                            labelText: 'Temperature : ',
                            labelStyle: kTextFormFieldLabelStyle,
                            errorStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
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
                            color:kTextInputColor,
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
                        decoration: const InputDecoration(
                          labelText: 'Humidity : ',
                          labelStyle: kTextFormFieldLabelStyle,
                          errorStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
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
                            color:kTextInputColor,
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
      ),
    );
  }
}
