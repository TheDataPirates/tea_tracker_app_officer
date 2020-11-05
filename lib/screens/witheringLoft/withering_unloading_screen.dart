import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_unloading.dart';

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
  );

  void _saveWitheringUnloadingProviderDetails(int troughN, int boxN) {
    final isValid = _formKeyWitheringUnloading.currentState.validate();

    if (!isValid) {
      return;
    }

    if(Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false).isTroughBoxUsed(troughN, boxN, DateTime.now())){
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You have already entered trough ' + '$troughN' + ' and box ' + '$boxN'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text('Please enter a different box in a trough !'),
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
      _formKeyWitheringUnloading.currentState.save();

      Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false)
          .addWitheringUnloadingItem(_witheringUnloading);

      Navigator.of(context).pushNamed('WitheringUnloadingView');
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

    final witheringUnloadingBatchNumber = Provider.of<WitheringLoadingUnloadingRollingProvider>(context);

    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Unloading'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: (){
              _saveWitheringUnloadingProviderDetails(int.parse(_troughNum.text), int.parse(_boxNum.text));
            },
            disabledColor: Colors.white,
            iconSize: 35.0,
          )
        ],
      ),
      body: SafeArea(
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
                      decoration: const InputDecoration(
                          labelText: 'Trough Number : ',
                          errorStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                          contentPadding: const EdgeInsets.all(30.0),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)))),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
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
                      decoration: const InputDecoration(
                          labelText: 'Box Number : ',
                          errorStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                          contentPadding: const EdgeInsets.all(30.0),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)))),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
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
                        );
                      },
                    ),
                  ),
                  Container(
                    height: _height * 0.2,
                    width: _width * 0.4,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Lot Weight : ',
                          errorStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                          contentPadding: const EdgeInsets.all(30.0),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)))),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Lot Weight !';
                        }
                        if (double.parse(value) <= 0 || double.parse(value) >= 201) {
                          return 'Please Enter A Valid Lot Weight !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _witheringUnloading = WitheringUnloading(
                          id: null,
                          batchNumber: witheringUnloadingBatchNumber.lastBatchNumberItem,
                          troughNumber: _witheringUnloading.troughNumber,
                          date: DateTime.now(),
                          boxNumber: _witheringUnloading.boxNumber,
                          lotWeight: double.parse(value),
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
    );
  }
}
