import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/bought_leaf/tea_collections_provider.dart';
import 'package:teatrackerappofficer/widgets/tea_acquiring_input.dart';

class InputCollectionScreen extends StatefulWidget {
  @override
  _InputCollectionScreenState createState() => _InputCollectionScreenState();
}

class _InputCollectionScreenState extends State<InputCollectionScreen> {
  final _containerTypeController = TextEditingController();
  final _containerNoController = TextEditingController();
  final _grossWeightController = TextEditingController();
  final _leafGradeController = TextEditingController();

  final _waterLevelController = TextEditingController();
  final _courseLeafController = TextEditingController();
  final _otherDeductController = TextEditingController();

  @override
  void dispose() {
    _containerTypeController.dispose();
    _containerNoController.dispose();
    _grossWeightController.dispose();
    _leafGradeController.dispose();
    _waterLevelController.dispose();
    _courseLeafController.dispose();
    _otherDeductController.dispose();
    super.dispose();
  }

  //media query width for row
  final double width = 0.15;
  final double deduct_width = 0.2;

  var _isLoading = false;

  Future<void> saveLot() async {
    if (_containerTypeController.text.isEmpty ||
        _containerNoController.text.isEmpty) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('AlertDialog'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('No supplier name entered'),
                  Text('Please Enter again'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    final provider = Provider.of<TeaCollections>(context, listen: false);

    final currentSupplier = provider
        .newSupplier; // get supplier id which entered on sup input screen via provider
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<TeaCollections>(context, listen: false).addLot(
        //get now time as lot ID
        currentSupplier.supplierId,
        currentSupplier.supplierName,
        _containerTypeController.text,
        int.parse(_containerNoController.text),
        int.parse(_grossWeightController.text),
        _leafGradeController.text,
        int.parse(_waterLevelController.text),
        int.parse(_courseLeafController.text),
        int.parse(_otherDeductController.text),
        provider.calDeduct(
          int.parse(_waterLevelController.text),
          int.parse(_courseLeafController.text),
          int.parse(_otherDeductController.text),
          int.parse(_grossWeightController.text),
        ),
        provider.calNetWeight(
          int.parse(_grossWeightController.text),
        ),
      );
    } catch (error) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('AlertDialog'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('An error occurred'),
                  Text('Something went wrong'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
//                      color: Colors.amber,
                            height: mediaQuery.height * 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
//                          InputField(
//                              labelText: 'Supplier No',
//                              width: width,
//                              editingController: _supplierController),
//                          SizedBox(
//                            width: MediaQuery.of(context).size.width * 0.005,
//                          ),
                                InputField(
                                    labelText: 'Container Type',
                                    width: width,
                                    editingController:
                                        _containerTypeController),
                                SizedBox(
                                  width: mediaQuery.width * 0.005,
                                ),
                                InputField(
                                    labelText: 'Container No',
                                    width: width,
                                    editingController: _containerNoController),
                                SizedBox(
                                  width: mediaQuery.width * 0.005,
                                ),
                                InputField(
                                    labelText: 'Gross weight',
                                    width: width,
                                    editingController: _grossWeightController),
                                SizedBox(
                                  width: mediaQuery.width * 0.005,
                                ),
                                InputField(
                                    labelText: 'Leaf Grade',
                                    width: width,
                                    editingController: _leafGradeController),
                                SizedBox(
                                  width: mediaQuery.width * 0.005,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: const Text(
                              'DEDUCTIONS',
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 10,
                              ),
                            ),
                          ),
                          Container(
//                      color: Colors.blue,
                            height: mediaQuery.height * 0.4,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InputField(
                                      labelText: 'Water %',
                                      width: deduct_width,
                                      editingController: _waterLevelController),
                                  SizedBox(
                                    width: mediaQuery.width * 0.05,
                                  ),
                                  InputField(
                                      labelText: 'Course Leaf %',
                                      width: deduct_width,
                                      editingController: _courseLeafController),
                                  SizedBox(
                                    width: mediaQuery.width * 0.05,
                                  ),
                                  InputField(
                                      labelText: 'Other %',
                                      width: deduct_width,
                                      editingController:
                                          _otherDeductController),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          ),
          Container(
            height: mediaQuery.height * 0.05,
            child: RaisedButton.icon(
              onPressed: saveLot,
              icon: const Icon(Icons.add),
              label: const Text(
                'SAVE',
                style: const TextStyle(fontSize: 20),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Colors.amber,
            ),
          )
        ],
      ),
    );
  }
}
