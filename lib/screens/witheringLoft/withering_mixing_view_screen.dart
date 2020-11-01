import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_mixing_provider.dart';
import 'package:teatrackerappofficer/widgets/withering_mixing_item.dart';

class WitheringMixingViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final witheringMixing = Provider.of<WitheringMixingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Mixing View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
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
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: const Icon(Icons.add, color: Colors.white,size: 40.0,),
            onPressed: (){
              Navigator.of(context).pushNamed('WitheringMixing');
            },
            backgroundColor: Colors.green,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
