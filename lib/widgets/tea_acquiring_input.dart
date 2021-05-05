import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../constants.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key key,
        @required double height,
        @required double width,
        @required this.labelText,
        TextEditingController editingController,
        this.validator,
        @required this.onSave,
        this.keytype})
      :
        _editingController = editingController,
        _height = height,
        _width = width,
        super(key: key);

  final String labelText;
  final TextEditingController _editingController;
  final List<String Function(dynamic)> validator;
  final Function onSave;
  final TextInputType keytype;
  final double _height;
  final double _width;

  @override
  Widget build(BuildContext context) {
//    final _height =
//        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
//
//    final _width = MediaQuery.of(context).size.width;
    return Card(
      color: inputCollectionfillColor,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * _width,
        decoration: BoxDecoration(
          color: inputCollectionfillColor,
          borderRadius: BorderRadius.circular(13),
        ),
        child: FormBuilderTextField(
          attribute: labelText,
          decoration: InputDecoration(
            errorStyle: TextStyle(
                fontSize: _height * 0.022, fontWeight: FontWeight.w700),
            contentPadding: EdgeInsets.fromLTRB(_width * 50,
                _height * 0.125, _width * 0, _height * 0.125),
            labelText: labelText,
            labelStyle: kInputScreenContainerDisplayText,
            enabledBorder: kEnabledBorder2,
            focusedBorder: kFocusedBorder2,
            focusedErrorBorder: kFocusedErrorBorder2,
            errorBorder: kErrorBorder2,
          ),
          validators: validator,
          controller: _editingController,
          keyboardType: keytype,
          onSaved: onSave,
          style: TextStyle(
              fontSize: _height * 0.07,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}