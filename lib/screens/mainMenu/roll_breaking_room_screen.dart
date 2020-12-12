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
                        decoration: const InputDecoration(
                          labelText: 'Batch Number : ',
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
                        decoration: const InputDecoration(
                          labelText: 'Roll Breaking Turn : ',
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
                        decoration: const InputDecoration(
                          labelText: 'Roll Breaker Number : ',
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
                        decoration: const InputDecoration(
                          labelText: 'Weight : ',
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
