import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/batch.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/withering_unloading_item.dart';

class WitheringUnloadingViewScreen extends StatefulWidget {

  @override
  _WitheringUnloadingViewScreenState createState() => _WitheringUnloadingViewScreenState();
}

class _WitheringUnloadingViewScreenState extends State<WitheringUnloadingViewScreen> {

  var _batch = Batch(id: null, batchNumber: null, batchWeight: null, time: null);

  void _saveBatchWeightAndNavigate (){

    Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false)
        .addBatchItem(_batch);

//    print(_batch.batchNumber);
//    print(_batch.batchWeight);

//    Navigator.of(context).pushNamed('MainMenu');
    Navigator.popUntil(context, ModalRoute.withName('MainMenu'));
  }

  @override
  Widget build(BuildContext context) {
    final witheringLoadingUnloading =
        Provider.of<WitheringLoadingUnloadingRollingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Unloading View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: (){
              _batch = Batch(
                  id: DateTime.now().toString(),
                  batchNumber: witheringLoadingUnloading.lastBatchNumberItem,
                  batchWeight: witheringLoadingUnloading.latestBatchTotalWeight,
                  time: DateTime.now(),
              );

              _saveBatchWeightAndNavigate();
            },
            disabledColor: Colors.white,
            iconSize: 35.0,
          )
        ],
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15.0),
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
            child: const Icon(
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
