import 'package:flutter/material.dart';



const kTextFieldLabelStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w700,
  color: Colors.white,
  height: 2,
);

const kTextLotlistStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w700,
  color: Colors.black,
  height: 2,
);

const kTextFormFieldLabelStyle = TextStyle(
color: Colors.white,
);

const kSupplierTextFormFieldText = TextStyle(
  color: Colors.white,
  fontSize: 26,
  fontWeight: FontWeight.bold,
);

const kUIGradient = LinearGradient(
  begin: Alignment.topCenter,
  end:Alignment.bottomCenter,
  colors: [
    const Color(0xff000000),
    const Color(0xff000000),
    // const Color(0xff159957),///1
    // const Color(0xff155799),///1
  ],
);

const kEnabledBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.lightGreen, width: 2.0),
    borderRadius: const BorderRadius.all(
        Radius.circular(50.0))
);

const kFocusedBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.lightGreen, width: 2.0),
    borderRadius: const BorderRadius.all(
        Radius.circular(50.0))
);

const kFocusedErrorBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red, width: 2.0),
    borderRadius: const BorderRadius.all(
        Radius.circular(50.0))
);

const kErrorBorder= OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red, width: 2.0),
    borderRadius: const BorderRadius.all(
        Radius.circular(50.0))
);

const kEmptyViewText = TextStyle(
  color: Colors.white,
  fontSize: 22,
);

const kInputScreenContainerDisplayText = TextStyle(
  color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w700,
);

const kEnabledBorder2 = OutlineInputBorder(
borderRadius: BorderRadius.all(
Radius.circular(13.0),
),
borderSide: const BorderSide(color: Colors.black87, width: 3.0),
);


const kFocusedBorder2 = OutlineInputBorder(
borderRadius: BorderRadius.all(
Radius.circular(13.0),
),
borderSide: const BorderSide(color: Colors.white, width: 2.0),
);


const kFocusedErrorBorder2 =  OutlineInputBorder(
borderRadius: BorderRadius.all(
Radius.circular(13.0),
),
borderSide: const BorderSide(color: Colors.red, width: 2.0),
);

const kErrorBorder2 = OutlineInputBorder(
borderRadius: BorderRadius.all(
Radius.circular(13.0),
),
borderSide: const BorderSide(color: Colors.red, width: 2.0),
);

const kURL = 'http://10.0.2.2:8080';
const kTextInputColor = Colors.white;

//BACKGROUND MODIFIED
var viewScreenBackgroundImage = DecorationImage(
  image: AssetImage("images/new1.jpg"),
  fit: BoxFit.cover,
  colorFilter: new ColorFilter.mode(
      Colors.black.withOpacity(0.8), BlendMode.dstATop),
);

var VASBackgroundImage = DecorationImage(
  image: AssetImage("images/new2.jpg"),
  fit: BoxFit.cover,
  colorFilter: new ColorFilter.mode(
      Colors.black.withOpacity(0.8), BlendMode.dstATop),
);

var reportBackgroundImage = DecorationImage(
  image: AssetImage("images/new4.jpg"),
  fit: BoxFit.cover,
  colorFilter: new ColorFilter.mode(
      Colors.black.withOpacity(0.8), BlendMode.dstATop),
);

var inputScreenBackgroundImage =  DecorationImage(
image: AssetImage("images/new3.jpg"),
fit: BoxFit.cover,
colorFilter: new ColorFilter.mode(
Colors.black.withOpacity(0.8), BlendMode.dstATop),
);

const printScreenBackgroundImage = DecorationImage(
  image: AssetImage("images/new5.jpg"),
  fit: BoxFit.cover,
  colorFilter: ColorFilter.mode(Color(0xE6000000),BlendMode.dstATop),
);

var textFieldfillColor = Colors.black.withOpacity(0.5);