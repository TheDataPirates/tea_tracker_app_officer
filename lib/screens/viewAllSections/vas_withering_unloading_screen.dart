import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/constants.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/withering_unloading_item.dart';

class VasWitheringUnloadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final witheringLoadingUnloading =
        Provider.of<WitheringLoadingUnloadingRollingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Unloading View'),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: kUIGradient),
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
                      'Total Batch ' +
                          '${witheringLoadingUnloading.lastBatchNumberItem}' +
                          ' Weight : ',
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
                            ' Kg',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      backgroundColor: Colors.greenAccent.shade700,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount:
                  witheringLoadingUnloading.witheringUnloadingItems.length,
              itemBuilder: (ctx, i) => WitheringUnloadingItem(
                id: witheringLoadingUnloading.witheringUnloadingItems[i].id,
                batchNumber: witheringLoadingUnloading
                    .witheringUnloadingItems[i].batchNumber,
                troughNumber: witheringLoadingUnloading
                    .witheringUnloadingItems[i].troughNumber,
                boxNumber: witheringLoadingUnloading
                    .witheringUnloadingItems[i].boxNumber,
                lotWeight: witheringLoadingUnloading
                    .witheringUnloadingItems[i].lotWeight,
                date: witheringLoadingUnloading.witheringUnloadingItems[i].date,
                witheringPercentage:
                    witheringLoadingUnloading.witheringTroughBoxDatePercentage(
                  troughNumber: witheringLoadingUnloading
                      .witheringUnloadingItems[i].troughNumber,
                  boxNumber: witheringLoadingUnloading
                      .witheringUnloadingItems[i].boxNumber,
                  date:
                      witheringLoadingUnloading.witheringUnloadingItems[i].date,
                  lotWeight: witheringLoadingUnloading
                      .witheringUnloadingItems[i].lotWeight,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}