import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering_starting_provider.dart';
import 'package:teatrackerappofficer/widgets/withering_starting_item.dart';

class WitheringStartingViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final witheringStarting = Provider.of<WitheringStartingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Withering Starting View'),
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
                itemCount: witheringStarting.witheringStartingItems.length,
                itemBuilder: (ctx, i) => WitheringStartingItem(
                  id: witheringStarting.witheringStartingItems[i].id,
                  troughNumber: witheringStarting.witheringStartingItems[i].troughNumber,
                  time: witheringStarting.witheringStartingItems[i].time,
                  temperature: witheringStarting.witheringStartingItems[i].temperature,
                  humidity: witheringStarting.witheringStartingItems[i].humidity,
                ),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: (){
          Navigator.of(context).pushNamed('WitheringStarting');
        },
        backgroundColor: Colors.green,
      ),
    );
  }
}
