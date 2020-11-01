import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/widgets/card_container_printing_screen.dart';

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
    return Card(
      elevation: 10.0,
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        child: TextField(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 5),
            filled: true,
//          fillColor: Colors.lightGreen,
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.green, fontSize: 30),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(13.0),
              ),
//              borderSide: BorderSide(color: Colors.greenAccent, width: 5),
              borderSide: BorderSide.none,
            ),
          ),
          controller: _editingController,
          style: TextStyle(
              fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
