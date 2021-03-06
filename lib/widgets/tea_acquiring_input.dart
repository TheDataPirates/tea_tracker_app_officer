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
      color: inputCollectionfillColor,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        decoration: BoxDecoration(
          color: inputCollectionfillColor,
          borderRadius: BorderRadius.circular(13),
        ),
        child: FormBuilderTextField(
          attribute: labelText,
          decoration: InputDecoration(
            errorStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            contentPadding:
            EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 40.0),
            labelText: labelText,
            labelStyle: kInputScreenContainerDisplayText,
            enabledBorder: kEnabledBorder2,
            focusedBorder: kFocusedBorder2,
            focusedErrorBorder:  kFocusedErrorBorder2,
            errorBorder: kErrorBorder2,
          ),
          validators: validator,
          controller: _editingController,
          keyboardType: keytype,
          onSaved: onSave,
          style: TextStyle(
              fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
