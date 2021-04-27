import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_starting_finishing.dart';
import 'package:teatrackerappofficer/constants.dart';

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

    if(Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false).isTroughFinished(int.parse(_troughNum.text), DateTime.now())){
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You have already finished trough ' + '${int.parse(_troughNum.text)}',style: TextStyle(color: Colors.white, fontSize: 18)),
            backgroundColor: Colors.black87,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text('Please enter a different trough number !',style: TextStyle (color: Colors.white, fontSize: 17),),
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
    }else if(!(Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false).isTroughStarted(int.parse(_troughNum.text), DateTime.now()))){
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You have not started trough ' + '${int.parse(_troughNum.text)}',style: TextStyle(color: Colors.white, fontSize: 18)),
            backgroundColor: Colors.black87,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text('Please enter a different trough number !',style: TextStyle (color: Colors.white, fontSize: 17),),
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
      _formKeyWitheringFinishing.currentState.save();
      try {
        await Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
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
                  title: const Text('Warning !',style: TextStyle(color: Colors.white, fontSize: 18)),
                  backgroundColor: Colors.black87,
                  content: ListBody(
                    children: <Widget>[
                      const Text('Error has occured',style: TextStyle (color: Colors.white, fontSize: 17),),
                      Text(error.toString(),style: TextStyle (color: Colors.white, fontSize: 17),),
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
            iconSize: _width * 0.04,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image : inputScreenBackgroundImage,
            gradient: kUIGradient,
        ),
        child: SafeArea(
          child: Form(
            key: _formKeyWitheringFinishing,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
//                      height: _height * 0.2,
                      width: _width * 0.45,
                      child: TextFormField(
                        controller: _troughNum,
                        decoration:  InputDecoration(
                          labelText: 'Trough Number : ',
                          labelStyle: kTextFormFieldLabelStyle,
                          fillColor:textFieldfillColor,
                          filled: true,
                          errorStyle:  TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _width * 0.02,
                          ),
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
//                      height: _height * 0.2,
                      width: _width * 0.45,
                      child: TextFormField(
                        decoration:  InputDecoration(
                          labelText: 'Temperature : ',
                          labelStyle: kTextFormFieldLabelStyle,
                          fillColor:textFieldfillColor,
                          filled: true,
                          errorStyle:  TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _width * 0.02,
                          ),
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
                            color:kTextInputColor
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
//                      height: _height * 0.2,
                      width: _width * 0.45,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Humidity : ',
                          labelStyle: kTextFormFieldLabelStyle,
                          fillColor:textFieldfillColor,
                          filled: true,
                          errorStyle:  TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _width * 0.02,
                          ),
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
      ),
    );
  }
}
