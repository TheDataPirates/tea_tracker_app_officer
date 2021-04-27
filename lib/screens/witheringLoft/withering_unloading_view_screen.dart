import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/batch.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/withering_unloading_item.dart';
import 'package:teatrackerappofficer/constants.dart';

class WitheringUnloadingViewScreen extends StatefulWidget {
  @override
  _WitheringUnloadingViewScreenState createState() =>
      _WitheringUnloadingViewScreenState();
}

class _WitheringUnloadingViewScreenState
    extends State<WitheringUnloadingViewScreen> {
  var _batch =
      Batch(id: null, batchNumber: null, batchWeight: null, time: null);

  Future<void> _saveBatchWeightAndNavigate() async {
    final authToken = Provider.of<Auth>(context, listen: false).token;

    Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
            listen: false)
        .addBatchItem(_batch, authToken);

//    print(_batch.batchNumber);
//    print(_batch.batchWeight);

//    Navigator.of(context).pushNamed('MainMenu');
    Navigator.popUntil(context, ModalRoute.withName('MainMenu'));
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final token = auth.token;
    final witheringLoadingUnloading =
        Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
            listen: false);
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Unloading View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              _batch = Batch(
                id: DateTime.now().toString(),
                batchNumber: witheringLoadingUnloading.lastBatchNumberItem,
                batchWeight: witheringLoadingUnloading.latestBatchTotalWeight,
                time: DateTime.now(),
              );
//              print('Entering Save function of batch');
              _saveBatchWeightAndNavigate();
            },
            disabledColor: Colors.white,
            iconSize: _width * 0.04,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: viewScreenBackgroundImage,
          gradient: kUIGradient,
        ),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(_width * 0.0075),
              color: Colors.black54,
              child: Padding(
                padding: EdgeInsets.all(_width * 0.0075),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Batch ' +
                          '${witheringLoadingUnloading.lastBatchNumberItem}' +
                          ' Weight : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width * 0.035,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: _width * 0.02,
                    ),
                    Chip(
                      label: Text(
                        '${witheringLoadingUnloading.latestBatchTotalWeight}' +
                            ' Kg',
                        style: TextStyle(
                            fontSize: _width * 0.025, color: Colors.white),
                      ),
                      backgroundColor: Colors.greenAccent.shade700,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: Provider.of<WitheringLoadingUnloadingRollingProvider>(
                        context,
                        listen: false)
                    .fetchAndSetWitheringUnloadingItem(token),
                builder: (ctx, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Consumer<WitheringLoadingUnloadingRollingProvider>(
                            child: Center(
                              child: const Text(
                                'Got no Withering unloading items found yet, start adding some!',
                                style: kEmptyViewText,
                              ),
                            ),
                            builder: (ctx,
                                    WitheringLoadingUnloadingRollingProvider,
                                    ch) =>
                                WitheringLoadingUnloadingRollingProvider
                                            .witheringUnloadingItems.length <=
                                        0
                                    ? ch
                                    : ListView.builder(
                                        itemCount:
                                            WitheringLoadingUnloadingRollingProvider
                                                .witheringUnloadingItems.length,
                                        itemBuilder: (ctx, i) =>
                                            WitheringUnloadingItem(
                                          id: WitheringLoadingUnloadingRollingProvider
                                              .witheringUnloadingItems[i].id,
                                          troughNumber:
                                              WitheringLoadingUnloadingRollingProvider
                                                  .witheringUnloadingItems[i]
                                                  .troughNumber,
                                          date:
                                              WitheringLoadingUnloadingRollingProvider
                                                  .witheringUnloadingItems[i]
                                                  .date,
                                          lotWeight:
                                              WitheringLoadingUnloadingRollingProvider
                                                  .witheringUnloadingItems[i]
                                                  .lotWeight,
                                          witheringPercentage:
                                              WitheringLoadingUnloadingRollingProvider
                                                  .witheringUnloadingItems[i]
                                                  .witheringPct,
                                          boxNumber:
                                              WitheringLoadingUnloadingRollingProvider
                                                  .witheringUnloadingItems[i]
                                                  .boxNumber,
                                          batchNumber:
                                              WitheringLoadingUnloadingRollingProvider
                                                  .witheringUnloadingItems[i]
                                                  .batchNumber,
                                        ),
                                      ),
                          ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        height: _height * 0.13,
        width: _width * 0.13,
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 10.0,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: _width * 0.06,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('WitheringUnloading');
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
