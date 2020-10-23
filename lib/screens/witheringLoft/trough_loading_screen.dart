import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/providers/withering_loading.dart';
import 'package:teatrackerappofficer/providers/withering_loading_unloading_provider.dart';
import 'package:provider/provider.dart';

class TroughLoadingScreen extends StatefulWidget {
  @override
  _TroughLoadingScreenState createState() => _TroughLoadingScreenState();
}

class _TroughLoadingScreenState extends State<TroughLoadingScreen> {
  final _formKeyTroughLoading = GlobalKey<FormState>();
  var _troughLoading = WitheringLoading(
      id: null,troughNumber: null, boxNumber: null, gradeOfGL: null, netWeight: null, date: null,);

  void _saveTroughArrangementDetails() {

    final isValid = _formKeyTroughLoading.currentState.validate();

    if(!isValid){
      return;
    }

    _formKeyTroughLoading.currentState.save();

//    print(_troughLoading.troughNumber);
//    print(_troughLoading.boxNumber);
//    print(_troughLoading.gradeOfGL);
//    print(_troughLoading.netWeight);

    Provider.of<WitheringLoadingUnloadingProvider>(context, listen: false).addTroughLoadingItem(_troughLoading);

    Navigator.of(context).pushNamed('TroughLoadingView');
  }

  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Trough Loading'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveTroughArrangementDetails ,
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
                      decoration: InputDecoration(
                          labelText: 'Trough Number : ',
                          errorStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                          contentPadding: EdgeInsets.all(30.0),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)))),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                      validator: (value){
                        if(value.isEmpty){
                          return 'Please Enter Trough Number !';
                        }
                        if(int.parse(value) >= 6 || int.parse(value) <= 0){
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
                            date: null,);
                      },
                    ),
                  ),
                  Container(
                    height: _height * 0.2,
                    width: _width * 0.4,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Box Number : ',
                          errorStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0
                          ),
                          contentPadding: EdgeInsets.all(30.0),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)))),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                      validator: (value){
                        if(value.isEmpty){
                          return 'Please Enter Box Number !';
                        }
                        if(int.parse(value) >= 11 || int.parse(value) <= 0){
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
                          date: null,);
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
                      decoration: InputDecoration(
                          labelText: 'Grade of GL : ',
                          errorStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0
                          ),
                          contentPadding: EdgeInsets.all(30.0),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)))),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                      validator: (value){
                        if(value.isEmpty){
                          return 'Please Enter Leaf Grade !';
                        }
                        if(value.length >= 2){
                          return 'Please Enter A Valid Leaf Grade !';
                        }
                        if((value != 'A') && (value != 'B') && (value != 'C') && (value != 'a') && (value != 'b') && (value != 'c')){
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
                          date: null,);
                      },
                    ),
                  ),
                  Container(
                    height: _height * 0.2,
                    width: _width * 0.4,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Net Weight : ',
                          errorStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0
                          ),
                          contentPadding: EdgeInsets.all(30.0),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)))),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                      validator: (value){
                        if(value.isEmpty){
                          return 'Please Enter Net Weight !';
                        }
                        if(double.parse(value) >= 201 || double.parse(value) <= 0){
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
                          date: DateTime.now(),);
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
