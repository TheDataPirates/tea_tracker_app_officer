import 'package:flutter/material.dart';

const kTextFieldLabelStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w700,
  color: Colors.white,
  height: 2,
);

const kTextLotlistStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w700,
  color: Colors.white,
  height: 1,
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
    borderSide: const BorderSide(color: Colors.white, width: 2.0),
    borderRadius: const BorderRadius.all(
        Radius.circular(50.0))
);

const kFocusedBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.white, width: 2.0),
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
  fontSize: 30,
  fontWeight: FontWeight.w700,
);

const kInputScreenContainerDisplayText = TextStyle(
  color: Colors.white,
    fontSize: 21,
    fontWeight: FontWeight.w700,
    height: 1,
);

const kEnabledBorder2 = OutlineInputBorder(
borderRadius: BorderRadius.all(
Radius.circular(13.0),
),
borderSide: const BorderSide(color: Colors.white, width: 1.0),
);


const kFocusedBorder2 = OutlineInputBorder(
borderRadius: BorderRadius.all(
Radius.circular(13.0),
),
borderSide: const BorderSide(color: Colors.white, width: 1.0),
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

// const kURL = 'https://tea-tracker-backend.herokuapp.com';
//const kURL = 'http://192.168.1.34:8080';
const kURL = 'http://192.168.1.100:8080';
//const kURL = 'http://10.0.2.2:8080';
const kTextInputColor = Colors.white;

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
  image: AssetImage("images/bg8.jpg"),
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

var printScreenBackgroundImage = DecorationImage(
  image: AssetImage("images/new5.jpg"),
  fit: BoxFit.cover,
  colorFilter: new ColorFilter.mode(
    Colors.black.withOpacity(0.8), BlendMode.dstATop),
);

var textFieldfillColor = Colors.black.withOpacity(0.5);

var inputCollectionfillColor = Colors.black.withOpacity(0.5);