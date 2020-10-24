import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_provider.dart';

class WitheringUnloadingBatchChoosingScreen extends StatefulWidget {
  @override
  _WitheringUnloadingBatchChoosingScreenState createState() =>
      _WitheringUnloadingBatchChoosingScreenState();
}

class _WitheringUnloadingBatchChoosingScreenState
    extends State<WitheringUnloadingBatchChoosingScreen> {

  final _formKeyWitheringUnloadingBatchChoosing = GlobalKey<FormState>();
  var batchNumberItem;

  void _saveWitheringUnloadingBatchNumberItem() {
    final isValid = _formKeyWitheringUnloadingBatchChoosing.currentState.validate();

    if (!isValid) {
      return;
    }

    _formKeyWitheringUnloadingBatchChoosing.currentState.save();

    Provider.of<WitheringLoadingUnloadingProvider>(context, listen: false)
        .addWitheringUnloadingBatchNumberItem(batchNumberItem);

//    Provider.of<WitheringLoadingUnloadingProvider>(context, listen: false)
//        .witheringUnloadingItems.clear();

    Navigator.of(context).pushNamed('WitheringUnloading');
  }

  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Withering Unloading Batch Choosing'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveWitheringUnloadingBatchNumberItem,
            disabledColor: Colors.white,
            iconSize: 35.0,
          )
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKeyWitheringUnloadingBatchChoosing,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: _height * 0.2,
                    width: _width * 0.4,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Batch Number : ',
                          errorStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                          contentPadding: EdgeInsets.all(30.0),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)))),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Batch Number !';
                        }
                        if (int.parse(value) >= 31 || int.parse(value) <= 0) {
                          return 'Please Enter A Valid Batch Number !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        batchNumberItem = int.parse(value);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
