import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:teatrackerappofficer/main.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/constants.dart';
import 'file:///E:/Uni/L2S1/Project/Frontend/lib/providers/bought_leaf/receipt.dart';
import 'package:teatrackerappofficer/providers/bought_leaf/tea_collections_provider.dart';
import 'package:teatrackerappofficer/screens/bought_leaf/print_preview_screen.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:teatrackerappofficer/providers/bought_leaf/user.dart';


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

  Future <void> initPlatformState() async{
    bool isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {

    }

    bluetooth.onStateChanged().listen((state){
      switch  (state) {
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

    if  (isConnected) {
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    // Container(
                    //   child: FormBuilderTextField(
                    //     // style: TextStyle(fontFamily: 'Montserrat', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    //     decoration: InputDecoration(
                    //       filled: true,
                    //       fillColor: Colors.black.withOpacity(0.8),
                    //     ),
                    //   ),
                    // ),
                    Text(
                      'Device : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Container(

                        decoration: BoxDecoration(

                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30.0),
                            border: Border.all()
                        ),
                          height: mediaQuery.height * 0.07,
                          width: mediaQuery.width * 0.5,
                          child: Container(
                            padding: const EdgeInsets.only(left: 20.0, right: 10.0,top: 5.0),
                            child: DropdownButton(
                              isExpanded: true,
                              items: _getDeviceItems(),
                              onChanged: (value) => setState(() => _device = value),
                              value: _device,
                              iconSize: 25,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                      )
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0),
                ),

                Column(
                  children: [
                    Container(
                      width: mediaQuery.width * 0.35,
                      height: mediaQuery.height * 0.07,

                       child: RaisedButton(
                          color: const Color(0xff099857),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          elevation: 15,
                          onPressed: () {
                            initPlatformState();
                          },
                          child: Text(
                            'REFRESH',
                            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                          ),
                        ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
                ),

                Container(
                  width: mediaQuery.width * 0.35,
                  height: mediaQuery.height * 0.07,
                  child: RaisedButton(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    color: _connected ? Colors.red : const Color(0xff099857),
                    onPressed: _connected ? _disconnect : _connect,
                    child: Text(
                      _connected ? 'Disconnect' : 'CONNECT',
                      style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
                ),

                Container(
                  width: mediaQuery.width * 0.35,
                  height: mediaQuery.height * 0.07,
                  child: RaisedButton(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    color: const Color(0xff099857),
                    onPressed: () {
                      receipt.sample(provider.currUser.user_id, provider.newSupplier.supplierName, provider.newSupplier.supplierId, gross, deductions, net);
                      Navigator.pushNamed(context, "MainMenuScreen");
                    },
                    child: Text(
                      'PRINT',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems(){
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if  (_devices.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text(
          'NONE',
        ),
      ));
    } else  {
      _devices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name,

          ),
          value: device,
        ));
      });
    }
    return items;
  }

  void _connect() {
    if  (_device == null) {
      show('No device selected');
    } else  {
      bluetooth.isConnected.then((isConnected){
        if  (!isConnected) {
          bluetooth.connect(_device).catchError((error){
            setState(() => _connected = false
            );
          });
          setState(() =>  _connected = true
          );
        }
      });
    }
  }

  void _disconnect()  {
    bluetooth.disconnect();
    setState(() => _connected = true);
  }

  Future show(
      String message, {
        Duration duration: const Duration(seconds: 3),
        }) async  {
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

