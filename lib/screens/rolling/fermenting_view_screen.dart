import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/fermenting_item.dart';

class FermentingViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fermenting = Provider.of<WitheringLoadingUnloadingRollingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Fermenting View'),
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
                itemCount: fermenting.fermentingItems.length,
                itemBuilder: (ctx, i) => FermentingItem(
                  id: fermenting.fermentingItems[i].id,
                  batchNumber: fermenting.fermentingItems[i].batchNumber,
                  dhoolNumber: fermenting.fermentingItems[i].dhoolNumber,
                  time: fermenting.fermentingItems[i].time,
                  dhoolInWeight: fermenting.fermentingItems[i].dhoolInWeight,
                  dhoolOutWeight: fermenting.fermentingItems[i].dhoolOutWeight,
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
              Navigator.of(context).pushNamed('FermentingRoom');
            },
            backgroundColor: Colors.green,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
