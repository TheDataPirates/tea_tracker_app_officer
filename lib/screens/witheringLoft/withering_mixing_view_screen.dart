import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering_mixing_provider.dart';
import 'package:teatrackerappofficer/widgets/withering_mixing_item.dart';

class WitheringMixingViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final witheringMixing = Provider.of<WitheringMixingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Withering Mixing View'),
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
                itemCount: witheringMixing.witheringMixingItems.length,
                itemBuilder: (ctx, i) => WitheringMixingItem(
                  id: witheringMixing.witheringMixingItems[i].id,
                  troughNumber: witheringMixing.witheringMixingItems[i].troughNumber,
                  turn: witheringMixing.witheringMixingItems[i].turn,
                  time: witheringMixing.witheringMixingItems[i].time,
                  temperature: witheringMixing.witheringMixingItems[i].temperature,
                  humidity: witheringMixing.witheringMixingItems[i].humidity,
                ),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: (){
          Navigator.of(context).pushNamed('WitheringMixing');
        },
        backgroundColor: Colors.green,
      ),
    );
  }
}
