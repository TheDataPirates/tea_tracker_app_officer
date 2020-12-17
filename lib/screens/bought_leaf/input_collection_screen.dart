import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/bought_leaf/lot.dart';
import 'package:teatrackerappofficer/providers/bought_leaf/tea_collections_provider.dart';
import 'package:teatrackerappofficer/widgets/tea_acquiring_input.dart';
import 'package:teatrackerappofficer/constants.dart';

class InputCollectionScreen extends StatefulWidget {
  @override
  _InputCollectionScreenState createState() => _InputCollectionScreenState();
}

class _InputCollectionScreenState extends State<InputCollectionScreen> {
  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();
  var _editedLot = Lot(
    container_type: '',
    no_of_containers: 0,
    gross_weight: 0,
    leaf_grade: '',
    water: 0,
    course_leaf: 0,
    other: 0,
  );

  @override
  void dispose() {
    super.dispose();
  }

  //media query width for row
  final double width = 0.2;
  final double deduct_width = 0.2;

  Future<void> saveLot() async {
    final auth = Provider.of<Auth>(context, listen: false);
    String token = auth.token;
    if (_fbkey.currentState.validate()) {
      _fbkey.currentState.save();
      print(_fbkey.currentState.value);

      final provider = Provider.of<TeaCollections>(context, listen: false);
      try {
        final currentSupplier = provider
            .newSupplier; // get supplier id which entered on sup input screen via provider
        await provider.addLot(
          token,
          currentSupplier.supplierId,
          currentSupplier.supplierName,
          _editedLot.container_type,
          _editedLot.no_of_containers,
          _editedLot.gross_weight,
          _editedLot.leaf_grade,
          _editedLot.water,
          _editedLot.course_leaf,
          _editedLot.other,
          provider.calDeduct(
            _editedLot.water,
            _editedLot.course_leaf,
            _editedLot.other,
            _editedLot.gross_weight,
            _editedLot.container_type,
            _editedLot.no_of_containers,
          ),
          provider.calNetWeight(_editedLot.gross_weight),
        );
        Navigator.of(context).pushNamed('LotListScreen');
      } catch (e) {
        //count should be 0 if not after click okay condition not true
        await showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
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
            );
          },
        );
        print('not valid');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: kUIGradient,
        ),
        child: FormBuilder(
          key: _fbkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Container(
//                      color: Colors.amber,
                          height: mediaQuery.height * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.0),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  width: mediaQuery.width * width,
                                  child: FormBuilderDropdown(
                                    attribute: "Container Type",
                                    decoration: InputDecoration(
                                      labelText: "  Container Type",
                                      errorStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 40.0),
                                      labelStyle: kInputScreenContainerDisplayText,
                                      enabledBorder: kEnabledBorder2,
                                      focusedBorder: kFocusedBorder2,
                                      focusedErrorBorder:  kFocusedErrorBorder2,
                                      errorBorder: kErrorBorder2,
                                    ),

                                  style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  // initialValue:

                                  validators: [
                                    FormBuilderValidators.required(),
                                    // ignore: missing_retur
                                  ],
                                  items: ['A', 'B', 'C', 'D', 'E']
                                      .map((container) => DropdownMenuItem(
                                          value: container,
                                          child: Text("$container")))
                                      .toList(),
                                  onSaved: (value) {
                                    _editedLot = Lot(
                                      container_type: value,
                                      no_of_containers:
                                          _editedLot.no_of_containers,
                                      gross_weight: _editedLot.gross_weight,
                                      leaf_grade: _editedLot.leaf_grade,
                                      water: _editedLot.water,
                                      course_leaf: _editedLot.course_leaf,
                                      other: _editedLot.other,
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: mediaQuery.width * 0.005,
                            ),
                            Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                width: mediaQuery.width * width,
                                child: FormBuilderDropdown(
                                  attribute: "No of Containers",
                                  decoration: InputDecoration(
                                    labelText: "No of Containers",
                                    errorStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 40.0),
                                    labelStyle: kInputScreenContainerDisplayText,
                                    enabledBorder: kEnabledBorder2,
                                    focusedBorder: kFocusedBorder2,
                                    focusedErrorBorder:  kFocusedErrorBorder2,
                                    errorBorder: kErrorBorder2,
                                    ),
                                    style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    // initialValue:

                                    validators: [
                                      FormBuilderValidators.required(),
                                    ],
                                    items: ['1', '2', '3', '4', '5']
                                        .map((container) => DropdownMenuItem(
                                            value: container,
                                            child: Text("$container")))
                                        .toList(),
                                    onSaved: (value) {
                                      _editedLot = Lot(
                                        container_type: _editedLot.container_type,
                                        no_of_containers: int.parse(value),
                                        gross_weight: _editedLot.gross_weight,
                                        leaf_grade: _editedLot.leaf_grade,
                                        water: _editedLot.water,
                                        course_leaf: _editedLot.course_leaf,
                                        other: _editedLot.other,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: mediaQuery.width * 0.005,
                              ),
                              InputField(
                                labelText: '  Gross weight',
                                width: width,
                                validator: [FormBuilderValidators.required()],
                                onSave: (value) {
                                  _editedLot = Lot(
                                    container_type: _editedLot.container_type,
                                    no_of_containers: _editedLot.no_of_containers,
                                    gross_weight: int.parse(value),
                                    leaf_grade: _editedLot.leaf_grade,
                                    water: _editedLot.water,
                                    course_leaf: _editedLot.course_leaf,
                                    other: _editedLot.other,
                                  );
                                },
                                keytype: TextInputType.number,
                              ),
                              SizedBox(
                                width: mediaQuery.width * 0.005,
                              ),
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.0),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  width: mediaQuery.width * width,
                                  child: FormBuilderDropdown(
                                    attribute: "Grade of GL",
                                    decoration: InputDecoration(
                                      labelText: "  Grade of GL",
                                      labelStyle: kInputScreenContainerDisplayText,
                                      errorStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 40.0),
                                      enabledBorder: kEnabledBorder2,
                                      focusedBorder: kFocusedBorder2,
                                      focusedErrorBorder:  kFocusedErrorBorder2,
                                      errorBorder: kErrorBorder2,
                                    ),
                                    style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    validators: [
                                      FormBuilderValidators.required(),
                                    ],
                                    items: ['A', 'B', 'C']
                                        .map((container) => DropdownMenuItem(
                                            value: container,
                                            child: Text("$container")))
                                        .toList(),
                                    onSaved: (value) {
                                      _editedLot = Lot(
                                        container_type: _editedLot.container_type,
                                        no_of_containers:
                                            _editedLot.no_of_containers,
                                        gross_weight: _editedLot.gross_weight,
                                        leaf_grade: value,
                                        water: _editedLot.water,
                                        course_leaf: _editedLot.course_leaf,
                                        other: _editedLot.other,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: mediaQuery.width * 0.005,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: mediaQuery.height * 0.2,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: const Text(
                                'DEDUCTIONS',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: mediaQuery.height * 0.2,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InputField(
                                  labelText: '  Water %',
                                  width: deduct_width,
                                  validator: [FormBuilderValidators.required()],
                                  onSave: (value) {
                                    _editedLot = Lot(
                                      container_type: _editedLot.container_type,
                                      no_of_containers:
                                          _editedLot.no_of_containers,
                                      gross_weight: _editedLot.gross_weight,
                                      leaf_grade: _editedLot.leaf_grade,
                                      water: int.parse(value),
                                      course_leaf: _editedLot.course_leaf,
                                      other: _editedLot.other,
                                    );
                                  },
                                  keytype: TextInputType.number,
                                ),
                                SizedBox(
                                  width: mediaQuery.width * 0.05,
                                ),
                                InputField(
                                  labelText: '  Course Leaf %',
                                  width: deduct_width,
                                  validator: [FormBuilderValidators.required()],
                                  onSave: (value) {
                                    _editedLot = Lot(
                                      container_type: _editedLot.container_type,
                                      no_of_containers:
                                          _editedLot.no_of_containers,
                                      gross_weight: _editedLot.gross_weight,
                                      leaf_grade: _editedLot.leaf_grade,
                                      water: _editedLot.water,
                                      course_leaf: int.parse(value),
                                      other: _editedLot.other,
                                    );
                                  },
                                  keytype: TextInputType.number,
                                ),
                                SizedBox(
                                  width: mediaQuery.width * 0.05,
                                ),
                                InputField(
                                  labelText: '  Other %',
                                  width: deduct_width,
                                  validator: [FormBuilderValidators.required()],
                                  onSave: (value) {
                                    _editedLot = Lot(
                                      container_type: _editedLot.container_type,
                                      no_of_containers:
                                          _editedLot.no_of_containers,
                                      gross_weight: _editedLot.gross_weight,
                                      leaf_grade: _editedLot.leaf_grade,
                                      water: _editedLot.water,
                                      course_leaf: _editedLot.course_leaf,
                                      other: int.parse(value),
                                    );
                                  },
                                  keytype: TextInputType.number,
                                ),
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
                  icon: const Icon(Icons.add, color: Colors.white,),
                  label: const Text(
                    'SAVE',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  color: const Color(0xff099857),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
