import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key key,
    @required this.labelText,
    @required this.width,
    @required TextEditingController editingController,
  })  : _editingController = editingController,
        super(key: key);

  final double width;
  final String labelText;
  final TextEditingController _editingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
          filled: true,
          fillColor: Colors.lightGreen,
          labelText: labelText,
          labelStyle: kTextFieldLabelStyle,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(13.0),
            ),
            borderSide: BorderSide.none,
          ),
        ),
        controller: _editingController,
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
