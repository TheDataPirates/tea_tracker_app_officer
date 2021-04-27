import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_starting_finishing.dart';
import 'package:teatrackerappofficer/constants.dart';


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
      humidity: null,);

  Future<void> _saveWitheringStartingProviderDetails() async {
    final authToken = Provider.of<Auth>(context, listen: false).token;

    final isValid = _formKeyWitheringStarting.currentState.validate();

    if (!isValid) {
      return;
    }

    if(Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false).isTroughStarted(int.parse(_troughNum.text), DateTime.now())){
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You have already started trough ' + '${int.parse(_troughNum.text)}',style: TextStyle (color: Colors.white, fontSize: 18),),
            backgroundColor: Colors.black87,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text('Please enter a different trough number !', style: TextStyle (color: Colors.white, fontSize: 17),),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK',style: TextStyle (fontSize: 17),),
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
      _formKeyWitheringStarting.currentState.save();
      try {
        await Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
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
                  title: const Text('Warning !',style: TextStyle (color: Colors.white, fontSize: 18),),
                  backgroundColor: Colors.black87,
                  content: ListBody(
                    children: <Widget>[
                      const Text('Error has occured',style: TextStyle (color: Colors.white, fontSize: 17),),
                      Text(e.toString(),style: TextStyle (color: Colors.white, fontSize: 17),),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Okay',style: TextStyle (fontSize: 17),),
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
    final _height = MediaQuery.of(context).size.height;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Starting'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: (){
              _saveWitheringStartingProviderDetails();
            },
            disabledColor: Colors.white,
            iconSize: _width * 0.04,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image : inputScreenBackgroundImage,
            gradient: kUIGradient,
        ),
        child: Form(
          key: _formKeyWitheringStarting,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal:_width * 0.005, vertical: _height * 0.1),
            child: ListView(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: _width * 0.25, vertical: _height * 0.1),
                  child: Container(
                    width: _width * 0.45,
//                    height: _height * 0.4,
                    child: Center(
                      child: TextFormField(
                        controller: _troughNum,
                        decoration:  InputDecoration(
                            labelText: 'Trough Number : ',
                            labelStyle: kTextFormFieldLabelStyle,
                            errorStyle:  TextStyle(
                                fontWeight: FontWeight.bold, fontSize: _width * 0.02),
                          fillColor:textFieldfillColor,
                          filled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: _width * 0.03, vertical: _height * 0.05),
                          enabledBorder: kEnabledBorder,
                          focusedBorder: kFocusedBorder,
                          focusedErrorBorder: kFocusedErrorBorder,
                          errorBorder: kErrorBorder,
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        style:  TextStyle(
                            fontSize: _width * 0.03, fontWeight: FontWeight.bold, color:kTextInputColor),
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
                      width: _width * 0.45,
//                      height: _height * 0.4,
                      child: TextFormField(
                        decoration:  InputDecoration(
                            labelText: 'Temperature : ',
                            labelStyle: kTextFormFieldLabelStyle,
                            errorStyle:  TextStyle(
                                fontWeight: FontWeight.bold, fontSize: _width * 0.02),
                          fillColor:textFieldfillColor,
                          filled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: _width * 0.03, vertical: _height * 0.05),
                          enabledBorder: kEnabledBorder,
                          focusedBorder: kFocusedBorder,
                          focusedErrorBorder: kFocusedErrorBorder,
                          errorBorder: kErrorBorder,
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        style:  TextStyle(
                            fontSize: _width * 0.03, fontWeight: FontWeight.bold, color:kTextInputColor),
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
//                      height: _height * 0.4,
                      width: _width * 0.45,
                      child: TextFormField(
                        decoration:  InputDecoration(
                            labelText: 'Humidity : ',
                            labelStyle: kTextFormFieldLabelStyle,
                            errorStyle:  TextStyle(
                                fontWeight: FontWeight.bold, fontSize: _width * 0.02),
                          fillColor:textFieldfillColor,
                          filled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: _width * 0.03, vertical: _height * 0.05),
                          enabledBorder: kEnabledBorder,
                          focusedBorder: kFocusedBorder,
                          focusedErrorBorder: kFocusedErrorBorder,
                          errorBorder: kErrorBorder,
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        style:  TextStyle(
                          fontSize: _width * 0.03,
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
      ),
    );
  }
}
