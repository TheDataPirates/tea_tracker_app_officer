import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../constants.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key key,
      @required this.labelText,
      @required this.width,
      TextEditingController editingController,
      this.validator,
      @required this.onSave,
      this.keytype})
      : _editingController = editingController,
        super(key: key);

  final double width;
  final String labelText;
  final TextEditingController _editingController;
  final List<String Function(dynamic)> validator;
  final Function onSave;
  final TextInputType keytype;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        child: FormBuilderTextField(
          attribute: labelText,
          decoration: InputDecoration(
            errorStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
//            filled: true,/**/
//          fillColor: Colors.lightGreen,
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.green, fontSize: 30),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(13.0),
              ),
              borderSide: BorderSide.none,
            ),
          ),
          validators: validator,
          controller: _editingController,
          keyboardType: keytype,
          onSaved: onSave,
          style: TextStyle(
              fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
