import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/roll_breaking_item.dart';


class RollBreakingViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rollBreaking = Provider.of<WitheringLoadingUnloadingRollingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Roll Breaking View'),
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
                itemCount: rollBreaking.rollBreakingItems.length,
                itemBuilder: (ctx, i) => RollBreakingItem(
                  id: rollBreaking.rollBreakingItems[i].id,
                  batchNumber: rollBreaking.rollBreakingItems[i].batchNumber,
                  rollBreakingTurn: rollBreaking.rollBreakingItems[i].rollBreakingTurn,
                  time: rollBreaking.rollBreakingItems[i].time,
                  rollBreakerNumber: rollBreaking.rollBreakingItems[i].rollBreakerNumber,
                  weight: rollBreaking.rollBreakingItems[i].weight,
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
              Navigator.of(context).pushNamed('RollBreakingRoom');
            },
            backgroundColor: Colors.green,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
