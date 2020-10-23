import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering_loading_unloading_provider.dart';
import 'package:teatrackerappofficer/widgets/withering_unloading_item.dart';

class WitheringUnloadingViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final witheringLoadingUnloading =
        Provider.of<WitheringLoadingUnloadingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Withering Unloading View'),
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
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Batch ' + '${witheringLoadingUnloading.lastBatchNumberItem}' + ' Weight : ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Chip(
                    label: Text(
                        '${witheringLoadingUnloading.latestBatchTotalWeight}' +
                            ' Kg', style: TextStyle(fontSize: 20.0, color: Colors.white),),

                    backgroundColor: Theme.of(context).primaryColor,

                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: witheringLoadingUnloading.witheringUnloadingItems.length,
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
                date: witheringLoadingUnloading.witheringUnloadingItems[i].date,
                lotWeight: witheringLoadingUnloading
                    .witheringUnloadingItems[i].lotWeight,
              ),
            ),
          ))
        ],
      ),
      floatingActionButton: Container(
        width: 70.0,
        height: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 40.0,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('WitheringUnloading');
            },
            backgroundColor: Colors.green,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
