import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering_unloading_provider.dart';

class WitheringUnloadingViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final witheringUnloading = Provider.of<WitheringUnloadingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Withering Unloading View'),
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
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Total Batch Weight : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,),),
                  SizedBox(width: 20.0,),
                  Chip(label: Text('${witheringUnloading.totalBatchWeight}' + ' Kg'),
                  backgroundColor: Theme.of(context).primaryColor,),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: witheringUnloading.witheringUnloadingItems.length,
//                itemBuilder: (ctx, i) => WitheringStartingFinishingItem(
//                  id: witheringFinishing.witheringFinishingItems[i].id,
//                  troughNumber: witheringFinishing.witheringFinishingItems[i].troughNumber,
//                  time: witheringFinishing.witheringFinishingItems[i].time,
//                  temperature: witheringFinishing.witheringFinishingItems[i].temperature,
//                  humidity: witheringFinishing.witheringFinishingItems[i].humidity,
//                ),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: (){
          Navigator.of(context).pushNamed('WitheringUnloading');
        },
        backgroundColor: Colors.green,
      ),
    );
  }
}
