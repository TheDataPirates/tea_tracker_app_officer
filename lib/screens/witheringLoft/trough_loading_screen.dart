import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:provider/provider.dart';

class TroughLoadingScreen extends StatefulWidget {
  @override
  _TroughLoadingScreenState createState() => _TroughLoadingScreenState();
}

class _TroughLoadingScreenState extends State<TroughLoadingScreen> {
  final _formKeyTroughLoading = GlobalKey<FormState>();
  var _troughLoading = WitheringLoading(
    id: null,
    troughNumber: null,
    boxNumber: null,
    gradeOfGL: null,
    netWeight: null,
    date: null,
  );

  Future<void> _saveTroughArrangementDetails() async {//int troughN, int boxN, String leafG
    final authToken = Provider.of<Auth>(context, listen: false).token;
    final isValid = _formKeyTroughLoading.currentState.validate();

    if (!isValid) {
      return;
    }

    if(Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false).isTroughBoxEnded(int.parse(_troughNum.text), int.parse(_boxNum.text), DateTime.now())){
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You have already ended trough ' + '${int.parse(_troughNum.text)}' + ' box ' + '${int.parse(_boxNum.text)}'),
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
    }else if(!Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false).isTroughBoxLeafGradeCorrect(int.parse(_troughNum.text), int.parse(_boxNum.text), _leafGrade.text, DateTime.now())){
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You have already entered different leaf grade in trough ' + '${int.parse(_troughNum.text)}' + ' box ' + '${int.parse(_boxNum.text)}'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text('Please check the Leaf Grade !'),
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
      _formKeyTroughLoading.currentState.save();
      try{
        await Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
            listen: false)
            .addTroughLoadingItem(_troughLoading, authToken);

        Navigator.of(context).pushNamed('TroughLoadingView');
      }catch (error) {
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
                      Text(error.toString()),
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
  final _boxNum = TextEditingController();
  final _leafGrade = TextEditingController();

  void dispose() {
    _troughNum.dispose();
    _boxNum.dispose();
    _leafGrade.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trough Loading'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: (){
              _saveTroughArrangementDetails();//int.parse(_troughNum.text), int.parse(_boxNum.text), _leafGrade.text
            },
            disabledColor: Colors.white,
            iconSize: 35.0,
          )
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKeyTroughLoading,
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
                          return 'Please Enter Trough Number !';
                        }
                        if (int.parse(value) >= 6 || int.parse(value) <= 0) {
                          return 'Please Enter A Valid Trough Number !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _troughLoading = WitheringLoading(
                          id: null,
                          troughNumber: int.parse(value),
                          boxNumber: _troughLoading.boxNumber,
                          gradeOfGL: _troughLoading.gradeOfGL,
                          netWeight: _troughLoading.netWeight,
                          date: null,
                        );
                      },
                    ),
                  ),
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
                          return 'Please Enter Box Number !';
                        }
                        if (int.parse(value) >= 11 || int.parse(value) <= 0) {
                          return 'Please Enter A Valid Box Number !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _troughLoading = WitheringLoading(
                          id: null,
                          troughNumber: _troughLoading.troughNumber,
                          boxNumber: int.parse(value),
                          gradeOfGL: _troughLoading.gradeOfGL,
                          netWeight: _troughLoading.netWeight,
                          date: null,
                        );
                      },
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: _height * 0.2,
                    width: _width * 0.4,
                    child: TextFormField(
                      controller: _leafGrade,
                      decoration: const InputDecoration(
                        labelText: 'Grade of GL : ',
                        errorStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                        contentPadding: const EdgeInsets.all(30.0),
                        border: const OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Leaf Grade !';
                        }
                        if (value.length >= 2) {
                          return 'Please Enter A Valid Leaf Grade !';
                        }
                        if ((value != 'A') &&
                            (value != 'B') &&
                            (value != 'C') &&
                            (value != 'a') &&
                            (value != 'b') &&
                            (value != 'c')) {
                          return 'Please Enter A Valid Leaf Grade !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _troughLoading = WitheringLoading(
                          id: null,
                          troughNumber: _troughLoading.troughNumber,
                          boxNumber: _troughLoading.boxNumber,
                          gradeOfGL: value,
                          netWeight: _troughLoading.netWeight,
                          date: null,
                        );
                      },
                    ),
                  ),
                  Container(
                    height: _height * 0.2,
                    width: _width * 0.4,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Net Weight : ',
                        errorStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
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
                          return 'Please Enter Net Weight !';
                        }
                        if (double.parse(value) >= 201 ||
                            double.parse(value) <= 0) {
                          return 'Please Enter A Valid Net Weight !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _troughLoading = WitheringLoading(
                          id: null,
                          troughNumber: _troughLoading.troughNumber,
                          boxNumber: _troughLoading.boxNumber,
                          gradeOfGL: _troughLoading.gradeOfGL,
                          netWeight: double.parse(value),
                          date: DateTime.now(),
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
