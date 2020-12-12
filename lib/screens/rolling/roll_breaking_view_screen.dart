import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/rolling/big_bulk.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/roll_breaking_item.dart';
import 'package:teatrackerappofficer/constants.dart';

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

  Future<void> _saveBigBulkDetails(String token) async {
    try {
      await Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
              listen: false)
          .addBigBulkItem(_bigBulk, token);

      print(_bigBulk.bigBulkNumber);
      print(_bigBulk.bigBulkWeight);

      Navigator.of(context).pushNamed('MainMenu');
    } catch (error) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AlertDialog(
                title: const Text('Warning !'),
                content: ListBody(
                  children: <Widget>[
                    const Text('Error has occured'),
                    Text(error.toString()),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Okay'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final rollBreaking = Provider.of<WitheringLoadingUnloadingRollingProvider>(
        context,
        listen: false);
    final token = Provider.of<Auth>(context, listen: false).token;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roll Breaking View'),
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
      body: Container(
        decoration: BoxDecoration(
            gradient: kUIGradient,
        ),
        child: FutureBuilder(
          future: Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
                  listen: false)
              .fetchAndSetWitheringRollBreakingItem(token),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<WitheringLoadingUnloadingRollingProvider>(
                  child: Center(
                    child: const Text(
                        'Got no Withering roll breaking items found yet, start adding some!'),
                  ),
                  builder: (ctx, WitheringLoadingUnloadingRollingProvider, ch) =>
                      WitheringLoadingUnloadingRollingProvider
                                  .rollBreakingItems.length <=
                              0
                          ? ch
                          : ListView.builder(
                              itemCount: WitheringLoadingUnloadingRollingProvider
                                  .rollBreakingItems.length,
                              itemBuilder: (ctx, i) => RollBreakingItem(
                                id: WitheringLoadingUnloadingRollingProvider
                                    .rollBreakingItems[i].id,
                                batchNumber:
                                    WitheringLoadingUnloadingRollingProvider
                                        .rollBreakingItems[i].batchNumber,
                                rollBreakingTurn:
                                    WitheringLoadingUnloadingRollingProvider
                                        .rollBreakingItems[i].rollBreakingTurn,
                                time: WitheringLoadingUnloadingRollingProvider
                                    .rollBreakingItems[i].time,
                                rollBreakerNumber:
                                    WitheringLoadingUnloadingRollingProvider
                                        .rollBreakingItems[i].rollBreakerNumber,
                                weight: WitheringLoadingUnloadingRollingProvider
                                    .rollBreakingItems[i].weight,
                              ),
                            ),
                ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
                  Navigator.of(context).pushNamed('RollBreakingRoom');
                },
                heroTag: null,
              ),
            ),
          ),
          SizedBox(
            width: 30.0,
          ),
          FloatingActionButton.extended(
            label: const Text(
              'End Batch',
              style: const TextStyle(
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
                    title: const Text('Are You Sure?'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          const Text('Do you want to end the batch?'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Yes'),
                        onPressed: () {
                          // Alert dialog should be shown and if yes store the bigbulk weight from the batch weight method in withering loading unloading rolling provider as the big bulk number equal to the batch number

                          _bigBulk = BigBulk(
                            id: DateTime.now().toString(),
                            bigBulkNumber:
                                rollBreaking.latestRollBreakingBatch(),
                            bigBulkWeight: rollBreaking.batchWeight(
                                rollBreaking.latestRollBreakingBatch(),
                                DateTime.now(),
                                rollBreaking.latestRollBreakingTurn() + 1),
                            time: DateTime.now(),
                          );

                          _saveBigBulkDetails(token);
                        },
                      ),
                      TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            heroTag: null,
          ),
        ],
      ),
    );
  }
}
