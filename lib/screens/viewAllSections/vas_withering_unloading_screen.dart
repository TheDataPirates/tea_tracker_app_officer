import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/batch.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/withering_unloading_item.dart';
import 'package:teatrackerappofficer/constants.dart';

class VasWitheringUnloadingScreen extends StatefulWidget {

  @override
  _VasWitheringUnloadingScreenState createState() => _VasWitheringUnloadingScreenState();
}

class _VasWitheringUnloadingScreenState extends State<VasWitheringUnloadingScreen> {

  var _batch = Batch(id: null, batchNumber: null, batchWeight: null, time: null);

  Future<void>_saveBatchWeightAndNavigate() async{

    final authToken = Provider.of<Auth>(context, listen: false).token;

    Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false)
        .addBatchItem(_batch,authToken);

    Navigator.popUntil(context, ModalRoute.withName('MainMenu'));
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final token = auth.token;
    final witheringLoadingUnloading =
    Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Unloading View'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image : VASBackgroundImage,
          gradient: kUIGradient,
        ),
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(15.0),
              color: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Batch ' + '${witheringLoadingUnloading.lastBatchNumberItem}' + ' Weight : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Chip(
                      label: Text(
                        '${witheringLoadingUnloading.latestBatchTotalWeight}' +
                            ' Kg', style: TextStyle(fontSize: 20.0, color: Colors.white),),

                      backgroundColor: Colors.greenAccent.shade700,

                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
                      listen: false)
                      .fetchAndSetWitheringUnloadingItem(token),
                  builder: (ctx, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : Consumer<WitheringLoadingUnloadingRollingProvider>(
                    child: Center(
                      child: const Text(
                        'Got no Withering Unloading items!', style: kEmptyViewText,),
                    ),
                    builder: (ctx, WitheringLoadingUnloadingRollingProvider, ch) =>
                    WitheringLoadingUnloadingRollingProvider
                        .witheringUnloadingItems.length <=
                        0
                        ? ch
                        : ListView.builder(
                      itemCount: WitheringLoadingUnloadingRollingProvider
                          .witheringUnloadingItems.length,
                      itemBuilder: (ctx, i) =>
                          WitheringUnloadingItem(
                            id: WitheringLoadingUnloadingRollingProvider
                                .witheringUnloadingItems[i].id,
                            troughNumber: WitheringLoadingUnloadingRollingProvider
                                .witheringUnloadingItems[i].troughNumber,
                            date: WitheringLoadingUnloadingRollingProvider
                                .witheringUnloadingItems[i].date,
                            lotWeight: WitheringLoadingUnloadingRollingProvider
                                .witheringUnloadingItems[i].lotWeight,
                            witheringPercentage: WitheringLoadingUnloadingRollingProvider
                                .witheringUnloadingItems[i].witheringPct,
                            boxNumber: WitheringLoadingUnloadingRollingProvider
                                .witheringUnloadingItems[i].boxNumber,
                            batchNumber: WitheringLoadingUnloadingRollingProvider
                                .witheringUnloadingItems[i].batchNumber,
                          ),
                    ),
                  ),
                ),
                // ListView.builder(
                //   itemCount: witheringLoadingUnloading.witheringUnloadingItems.length,
                //   itemBuilder: (ctx, i) => WitheringUnloadingItem(
                //     id: witheringLoadingUnloading.witheringUnloadingItems[i].id,
                //     batchNumber: witheringLoadingUnloading
                //         .witheringUnloadingItems[i].batchNumber,
                //     troughNumber: witheringLoadingUnloading
                //         .witheringUnloadingItems[i].troughNumber,
                //     boxNumber: witheringLoadingUnloading
                //         .witheringUnloadingItems[i].boxNumber,
                //     lotWeight: witheringLoadingUnloading
                //         .witheringUnloadingItems[i].lotWeight,
                //     date: witheringLoadingUnloading.witheringUnloadingItems[i].date,
                //     witheringPercentage:
                //     witheringLoadingUnloading.witheringTroughBoxDatePercentage(
                //       troughNumber: witheringLoadingUnloading
                //           .witheringUnloadingItems[i].troughNumber,
                //       boxNumber: witheringLoadingUnloading
                //           .witheringUnloadingItems[i].boxNumber,
                //       date: witheringLoadingUnloading.witheringUnloadingItems[i].date,
                //       lotWeight: witheringLoadingUnloading
                //           .witheringUnloadingItems[i].lotWeight,
                //     ),
                //   ),
                // )
              )
          ],
        ),
      ),
    );
  }
}
