import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/drying_item.dart';

class DrierOutputViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final drying = Provider.of<WitheringLoadingUnloadingRollingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Drier Output View'),
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
                itemCount: drying.dryingItems.length,
                itemBuilder: (ctx, i) => DryingItem(
                  id: drying.dryingItems[i].id,
                  batchNumber: drying.dryingItems[i].batchNumber,
                  dhoolNumber: drying.dryingItems[i].dhoolNumber,
                  time: drying.dryingItems[i].time,
                  drierInWeight: drying.dryingItems[i].drierInWeight,
                  drierOutWeight: drying.dryingItems[i].drierOutWeight,
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
              Navigator.of(context).pushNamed('DrierOutput');
            },
            backgroundColor: Colors.green,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
