import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/constants.dart';

class WitheringUnloadingBatchChoosingScreen extends StatefulWidget {
  @override
  _WitheringUnloadingBatchChoosingScreenState createState() =>
      _WitheringUnloadingBatchChoosingScreenState();
}

class _WitheringUnloadingBatchChoosingScreenState
    extends State<WitheringUnloadingBatchChoosingScreen> {

  final _formKeyWitheringUnloadingBatchChoosing = GlobalKey<FormState>();
  var batchNumberItem;

  void _saveWitheringUnloadingBatchNumberItem() {
    final isValid = _formKeyWitheringUnloadingBatchChoosing.currentState.validate();

    if (!isValid) {
      return;
    }

//    print(Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false).isBatchNumberUsed(batchNo));

    if(Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false).isBatchNumberUsed(int.parse(_batchNum.text), DateTime.now())){
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You have already made batch ' + '${int.parse(_batchNum.text)}'),
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
//    print(batchNo);
//    return;
    }else{
      _formKeyWitheringUnloadingBatchChoosing.currentState.save();

      Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false)
          .addWitheringUnloadingBatchNumberItem(batchNumberItem);

//    Provider.of<WitheringLoadingUnloadingProvider>(context, listen: false)
//        .witheringUnloadingItems.clear();

      Navigator.of(context).pushNamed('WitheringUnloading');
    }


  }

  final _batchNum = TextEditingController();

  void dispose() {
    _batchNum.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

//    int batchNum = 0;


    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Unloading Batch Choosing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: (){
              _saveWitheringUnloadingBatchNumberItem();
            },
            disabledColor: Colors.white,
            iconSize: 35.0,
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
            key: _formKeyWitheringUnloadingBatchChoosing,
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
                            fontSize: 30.0, fontWeight: FontWeight.bold, color:kTextInputColor),
                        validator: (value) {
//                        batchNum = int.parse(value);
                          if (value.isEmpty) {
                            return 'Please Enter Batch Number !';
                          }
                          if (int.parse(value) >= 31 || int.parse(value) <= 0) {
                            return 'Please Enter A Valid Batch Number !';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          batchNumberItem = int.parse(value);
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
