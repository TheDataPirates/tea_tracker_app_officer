import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/rolling/roll_breaking.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/constants.dart';

class RollBreakingRoomScreen extends StatefulWidget {
  @override
  _RollBreakingRoomScreenState createState() => _RollBreakingRoomScreenState();
}

class _RollBreakingRoomScreenState extends State<RollBreakingRoomScreen> {
  final _formKeyRollBreaking = GlobalKey<FormState>();
  var _rollBreaking = RollBreaking(
      id: null,
      batchNumber: null,
      rollBreakingTurn: null,
      time: null,
      rollBreakerNumber: null,
      weight: null);

  Future<void> _saveRollBreakingProviderDetails() async {
    final authToken = Provider.of<Auth>(context, listen: false).token;
    final isValid = _formKeyRollBreaking.currentState.validate();

    if (!isValid) {
      return;
    }

    if(Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false).isBatchRollBreakingTurnAlreadyUsed(int.parse(_batchNum.text), int.parse(_rollBreakingTurn.text), DateTime.now())){
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black87,
            title: Text('You have already used rollbreaking turn ' + '${int.parse(_rollBreakingTurn.text)}' + ' on batch ' + '${int.parse(_batchNum.text)}',style: TextStyle(color: Colors.white, fontSize: 18),),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text('Please enter a different rollbreaking turn !',style: TextStyle(color: Colors.white, fontSize: 17),),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK',style: TextStyle(fontSize: 17),),
                onPressed: () {
                  Navigator.pop(context);
                  return;
                },
              ),
            ],
          );
        },
      );
    }else if (Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false).isBatchEnded(int.parse(_batchNum.text), DateTime.now())){
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You have already ended batch ' + '${int.parse(_batchNum.text)}',style: TextStyle(color: Colors.white, fontSize: 18),),
            backgroundColor: Colors.black87,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text('Please try a different batch number !',style: TextStyle(color: Colors.white, fontSize: 17),),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK',style: TextStyle(fontSize: 17),),
                onPressed: () {
                  Navigator.pop(context);
                  return;
                },
              ),
            ],
          );
        },
      );
    }else if(!(Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false).isBatchMade(int.parse(_batchNum.text), DateTime.now()))){
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You have not created batch ' + '${int.parse(_batchNum.text)}',style: TextStyle(color: Colors.white, fontSize: 18),),
            backgroundColor: Colors.black87,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text('Please enter a different batch number !',style: TextStyle(color: Colors.white, fontSize: 17),),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK',style: TextStyle(fontSize: 17),),
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
      _formKeyRollBreaking.currentState.save();
      try {
        await Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
            listen: false)
            .addRollBreakingItem(_rollBreaking, authToken);

        Navigator.of(context).pushNamed('RollBreakingView');
      } catch (e) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: AlertDialog(
                  title: const Text('Warning !',style: TextStyle(color: Colors.white, fontSize: 18),),
                  backgroundColor: Colors.black87,
                  content: ListBody(
                    children: <Widget>[
                      const Text('Error has occured',style: TextStyle(color: Colors.white, fontSize: 17),),
                      Text(e.toString(),style: TextStyle(color: Colors.white, fontSize: 17),),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Okay',style: TextStyle(fontSize: 17),),
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
  final _rollBreakingTurn = TextEditingController();


  void dispose() {
    _batchNum.dispose();
    _rollBreakingTurn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Roll Breaking Room'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveRollBreakingProviderDetails,
            disabledColor: Colors.white,
            iconSize: 35.0,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image : inputScreenBackgroundImage,
          gradient: kUIGradient,
        ),
        child: SafeArea(
          child: Form(
            key: _formKeyRollBreaking,
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
                        decoration:  InputDecoration(
                          labelText: 'Batch Number : ',
                          labelStyle: kTextFormFieldLabelStyle,
                          fillColor:textFieldfillColor,
                          filled: true,
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
                          _rollBreaking = RollBreaking(
                            id: null,
                            batchNumber: int.parse(value),
                            rollBreakingTurn: _rollBreaking.rollBreakingTurn,
                            time: null,
                            rollBreakerNumber: _rollBreaking.rollBreakerNumber,
                            weight: _rollBreaking.weight,
                          );
                        },
                      ),
                    ),
                    Container(
                      height: _height * 0.2,
                      width: _width * 0.4,
                      child: TextFormField(
                        controller: _rollBreakingTurn,
                        decoration:  InputDecoration(
                          labelText: 'Roll Breaking Turn : ',
                          labelStyle: kTextFormFieldLabelStyle,
                          fillColor:textFieldfillColor,
                          filled: true,
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
                            return 'Please Enter Roll Breaking Turn !';
                          }
                          if (int.parse(value) >= 6 || int.parse(value) <= 0) {
                            return 'Please Enter A Valid Roll Breaking Turn !';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _rollBreaking = RollBreaking(
                            id: null,
                            batchNumber: _rollBreaking.batchNumber,
                            rollBreakingTurn: int.parse(value),
                            time: null,
                            rollBreakerNumber: _rollBreaking.rollBreakerNumber,
                            weight: _rollBreaking.weight,
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
                        decoration: InputDecoration(
                          labelText: 'Roll Breaker Number : ',
                          labelStyle: kTextFormFieldLabelStyle,
                          fillColor:textFieldfillColor,
                          filled: true,
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
                            return 'Please Enter Roll Breaker Number !';
                          }
                          if (int.parse(value) <= 0 || int.parse(value) >= 3) {
                            return 'Please Enter A Valid Roll Breaker Number !';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _rollBreaking = RollBreaking(
                            id: null,
                            batchNumber: _rollBreaking.batchNumber,
                            rollBreakingTurn: _rollBreaking.rollBreakingTurn,
                            time: null,
                            rollBreakerNumber: int.parse(value),
                            weight: _rollBreaking.weight,
                          );
                        },
                      ),
                    ),
                    Container(
                      height: _height * 0.2,
                      width: _width * 0.4,
                      child: TextFormField(
                        decoration:  InputDecoration(
                          labelText: 'Weight : ',
                          labelStyle: kTextFormFieldLabelStyle,
                          fillColor:textFieldfillColor,
                          filled: true,
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
                            return 'Please Enter Weight !';
                          }
                          if (int.parse(value) <= 0 || int.parse(value) >= 51) {
                            return 'Please Enter A Valid Weight !';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _rollBreaking = RollBreaking(
                            id: null,
                            batchNumber: _rollBreaking.batchNumber,
                            rollBreakingTurn: _rollBreaking.rollBreakingTurn,
                            time: DateTime.now(),
                            rollBreakerNumber: _rollBreaking.rollBreakerNumber,
                            weight: double.parse(value),
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
