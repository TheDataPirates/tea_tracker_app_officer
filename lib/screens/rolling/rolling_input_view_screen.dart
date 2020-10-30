import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/rolling_item.dart';

class RollingInputViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rollingInput =
        Provider.of<WitheringLoadingUnloadingRollingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rolling Input View'),
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
            itemCount: rollingInput.rollingInputItems.length,
            itemBuilder: (ctx, i) => RollingItem(
              id: rollingInput.rollingInputItems[i].id,
              batchNumber: rollingInput.rollingInputItems[i].batchNumber,
              rollingTurn: rollingInput.rollingInputItems[i].rollingTurn,
              time: rollingInput.rollingInputItems[i].time,
              rollerNumber: rollingInput.rollingInputItems[i].rollerNumber,
              weight: rollingInput.rollingInputItems[i].weight,
            ),
          ))
        ],
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 40.0,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('RollingInput');
            },
            backgroundColor: Colors.green,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
