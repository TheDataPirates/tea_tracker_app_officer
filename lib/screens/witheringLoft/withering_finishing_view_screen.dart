import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering_starting__finishing_provider.dart';
import 'package:teatrackerappofficer/widgets/withering_starting_finishing_item.dart';

class WitheringFinishingViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final witheringFinishing = Provider.of<WitheringStartingFinishingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Withering Finishing View'),
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
                itemCount: witheringFinishing.witheringFinishingItems.length,
                itemBuilder: (ctx, i) => WitheringStartingFinishingItem(
                  id: witheringFinishing.witheringFinishingItems[i].id,
                  troughNumber: witheringFinishing.witheringFinishingItems[i].troughNumber,
                  time: witheringFinishing.witheringFinishingItems[i].time,
                  temperature: witheringFinishing.witheringFinishingItems[i].temperature,
                  humidity: witheringFinishing.witheringFinishingItems[i].humidity,
                ),
              ))
        ],
      ),
      floatingActionButton: Container(
        width: 70.0,
        height: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(Icons.add, color: Colors.white,size: 40.0,),

            onPressed: (){
              Navigator.of(context).pushNamed('WitheringFinishing');
            },
            backgroundColor: Colors.green,
          ),
        ),
      ),
    );
  }
}
