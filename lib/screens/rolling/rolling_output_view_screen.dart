import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/rolling_item.dart';

class RollingOutputViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rollingOutput = Provider.of<WitheringLoadingUnloadingRollingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Rolling Output View'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.of(context).pushNamed('MainMenu');
            },
            disabledColor: Colors.white,
            iconSize: 35.0,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: rollingOutput.rollingOutputItems.length,
                itemBuilder: (ctx, i) => RollingItem(
                  id: rollingOutput.rollingOutputItems[i].id,
                  batchNumber: rollingOutput.rollingOutputItems[i].batchNumber,
                  rollingTurn: rollingOutput.rollingOutputItems[i].rollingTurn,
                  time: rollingOutput.rollingOutputItems[i].time,
                  rollerNumber: rollingOutput.rollingOutputItems[i].rollerNumber,
                  weight: rollingOutput.rollingOutputItems[i].weight,
                ),
              ))
        ],
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(Icons.add, color: Colors.white,size: 40.0,),
            onPressed: (){
              Navigator.of(context).pushNamed('RollingOutput');
            },
            backgroundColor: Colors.green,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}