import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/drying_item.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';

class DrierOutputViewScreen extends StatefulWidget {
  @override
  // Widget build(BuildContext context) {
  //   final drying =
  //   Provider.of<WitheringLoadingUnloadingRollingProvider>(context);
  _DrierOutPutViewScreenState createState () => _DrierOutPutViewScreenState();
  }

class _DrierOutPutViewScreenState extends State<DrierOutputViewScreen> {
  @override
    Widget build(BuildContext context) {
    final token = Provider.of<Auth>(context, listen: false).token;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drier Output View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
//              Navigator.of(context).pushNamed('MainMenu');
              Navigator.popUntil(context, ModalRoute.withName('MainMenu'));
            },
            disabledColor: Colors.white,
            iconSize: 35.0,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                future: Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
                    listen: false)
                    .fetchAndSetDryingItem(token),
                builder: (ctx, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : Consumer<WitheringLoadingUnloadingRollingProvider>(
                  child: Center(
                    child: const Text(
                        'Got no drying items found yet, start adding some!'),
                  ),
                  builder: (ctx, WitheringLoadingUnloadingRollingProvider, ch) =>
                  WitheringLoadingUnloadingRollingProvider
                      .dryingItems.length <=
                      0
                      ? ch
                      : ListView.builder(
                    itemCount: WitheringLoadingUnloadingRollingProvider
                        .dryingItems.length,
                    itemBuilder: (ctx, i) => DryingItem(
                      id: WitheringLoadingUnloadingRollingProvider
                          .dryingItems[i].id,
                      batchNumber:
                      WitheringLoadingUnloadingRollingProvider
                          .dryingItems[i].batchNumber,
                      dhoolNumber:
                      WitheringLoadingUnloadingRollingProvider
                          .dryingItems[i].dhoolNumber,
                      time: WitheringLoadingUnloadingRollingProvider
                          .dryingItems[i].time,
                      drierInWeight:
                      WitheringLoadingUnloadingRollingProvider
                          .dryingItems[i].drierInWeight,
                      drierOutWeight:
                      WitheringLoadingUnloadingRollingProvider
                          .dryingItems[i].drierOutWeight,
                    ),
                  ),
                ),
              ),
          )
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
              Navigator.of(context).pushNamed('DrierOutput');
            },
            backgroundColor: Colors.green,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
