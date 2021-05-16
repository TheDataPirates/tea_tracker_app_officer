import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/constants.dart';
import 'package:teatrackerappofficer/providers/bought_leaf/receipt.dart';
import 'package:teatrackerappofficer/providers/bought_leaf/tea_collections_provider.dart';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class PrintScreen extends StatefulWidget {
  @override
  _PrintScreenState createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<BluetoothDevice> _devices = [];
  BluetoothDevice _device;
  bool _connected = false;
  String pathImage;
  Receipt receipt;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    receipt = Receipt();
  }

  Future<void> initPlatformState() async {
    bool isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {}

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
          });
          break;
        default:
          print(state);
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final provider = Provider.of<TeaCollections>(context, listen: false);
    final deductions = provider.totalDeducts();
    final net = provider.netWeight();
    final gross = provider.grossWeight();
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/p1.jpg'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.7), BlendMode.dstATop),
            ),
            gradient: kUIGradient,
          ),
          child: Padding(
            padding:  EdgeInsets.all(mediaQuery.width * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: mediaQuery.width * 0.025,
                    ),
                    Text(
                      'Device : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: mediaQuery.width * 0.04,
                      ),
                    ),
                    SizedBox(
                      width: mediaQuery.width * 0.04,
                    ),
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all()),
                            height: mediaQuery.height * 0.09,
                            width: mediaQuery.width * 0.5,
                            child: Container(
                              padding:  EdgeInsets.only(
                                  left: mediaQuery.width * 0.03, right: mediaQuery.width * 0.02, top: mediaQuery.height * 0.01, bottom: mediaQuery.height * 0.01),
                              child: DropdownButton(
                                isExpanded: true,
                                items: _getDeviceItems(),
                                onChanged: (value) =>
                                    setState(() => _device = value),
                                value: _device,
                                iconSize: mediaQuery.height * 0.06,
                                style: TextStyle(
                                  fontSize: mediaQuery.height * 0.04,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                dropdownColor: Colors.black54,
                              ),
                            )))
                  ],
                ),
                SizedBox(
                  height: mediaQuery.height * 0.125,
                ),
                Column(
                  children: [
                    Container(
                      width: mediaQuery.width * 0.35,
                      height: mediaQuery.height * 0.09,
                      child: RaisedButton(
                        color: const Color(0xff099857),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: mediaQuery.height * 0.01, horizontal: mediaQuery.width * 0.01),
                        elevation: 15,
                        onPressed: () {
                          initPlatformState();
                        },
                        child: Text(
                          'REFRESH',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: mediaQuery.height * 0.06,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaQuery.height * 0.04,
                ),
                Container(
                  width: mediaQuery.width * 0.35,
                  height: mediaQuery.height * 0.09,
                  child: RaisedButton(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: mediaQuery.height * 0.01, horizontal: mediaQuery.width * 0.01),
                    color: _connected ? Colors.yellow : const Color(0xff099857),
                    onPressed: _connected ? _disconnect : _connect,
                    child: Text(
                      _connected ? 'Disconnect' : 'CONNECT',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: mediaQuery.height * 0.06,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.04,
                ),
                Container(
                  width: mediaQuery.width * 0.35,
                  height: mediaQuery.height * 0.09,
                  child: RaisedButton(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: mediaQuery.height * 0.01, horizontal: mediaQuery.width * 0.01),
                    color: const Color(0xff099857),
                    onPressed: () {
                      receipt.sample(
                          provider.currUser.user_id,
                          provider.newSupplier.supplierId,
                          provider.newSupplier.supplierName,
                          gross,
                          deductions,
                          net);
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.pushNamed(context, "MainMenu");
                    },
                    child: Text(
                      'PRINT',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: mediaQuery.height * 0.06,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text(
          'NONE',
        ),
      ));
    } else {
      _devices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(
            device.name,
          ),
          value: device,
        ));
      });
    }
    return items;
  }

  void _connect() {
    if (_device == null) {
      show('No device selected');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected) {
          bluetooth.connect(_device).catchError((error) {
            setState(() => _connected = false);
          });
          setState(() => _connected = true);
        }
      });
    }
  }

  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _connected = true);
  }

  Future show(
    String message, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          message,
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
        duration: duration,
      ),
    );
  }
}
