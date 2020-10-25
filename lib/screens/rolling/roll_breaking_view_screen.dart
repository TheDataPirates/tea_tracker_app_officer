import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/rolling/big_bulk.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/roll_breaking_item.dart';

class RollBreakingViewScreen extends StatefulWidget {
  @override
  _RollBreakingViewScreenState createState() => _RollBreakingViewScreenState();
}

class _RollBreakingViewScreenState extends State<RollBreakingViewScreen> {
  var _bigBulk = BigBulk(
    id: null,
    bigBulkNumber: null,
    bigBulkWeight: null,
    time: null,
  );

  void _saveBigBulkDetails() {
    Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
            listen: false)
        .addBigBulkItem(_bigBulk);

    print(_bigBulk.bigBulkNumber);
    print(_bigBulk.bigBulkWeight);

    Navigator.of(context).pushNamed('MainMenu');
  }

  @override
  Widget build(BuildContext context) {
    final rollBreaking =
        Provider.of<WitheringLoadingUnloadingRollingProvider>(context);
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
              rollBreakingTurn:
                  rollBreaking.rollBreakingItems[i].rollBreakingTurn,
              time: rollBreaking.rollBreakingItems[i].time,
              rollBreakerNumber:
                  rollBreaking.rollBreakingItems[i].rollBreakerNumber,
              weight: rollBreaking.rollBreakingItems[i].weight,
            ),
          ))
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70.0,
            width: 70.0,
            child: FittedBox(
              child: FloatingActionButton(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40.0,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('RollBreakingRoom');
                },
                backgroundColor: Colors.green,
                heroTag: null,
              ),
            ),
          ),
          SizedBox(
            width: 30.0,
          ),
          FloatingActionButton.extended(
            label: Text(
              'End Batch',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              return showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Are You Sure?'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Do you want to end the batch?'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Yes'),
                        onPressed: () {
                          // Alert dialog should be shown and if yes store the bigbulk weight from the batch weight method in withering loading unloading rolling provider as the big bulk number equal to the batch number

                          _bigBulk = BigBulk(
                            id: DateTime.now().toString(),
                            bigBulkNumber: rollBreaking.latestRollBreakingBatch(),
                            bigBulkWeight: rollBreaking.batchWeight(rollBreaking.latestRollBreakingBatch(), DateTime.now(), rollBreaking.latestRollBreakingTurn() + 1),
                            time: DateTime.now(),
                          );

                          _saveBigBulkDetails();
                        },
                      ),
                      TextButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            backgroundColor: Colors.green,
            heroTag: null,
          ),
        ],
      ),
    );
  }
}
