import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/ended_loading_trough_box.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/trough_loading_item.dart';
import 'package:teatrackerappofficer/constants.dart';

class RemeasureTroughLoadingViewScreen extends StatefulWidget {
  @override
  _RemeasureTroughLoadingViewScreenState createState() =>
      _RemeasureTroughLoadingViewScreenState();
}

class _RemeasureTroughLoadingViewScreenState extends State<RemeasureTroughLoadingViewScreen> {
  var _endedLoadingTroughBox = EndedLoadingTroughBox(
    id: null,
    troughNumber: null,
    boxNumber: null,
    date: null,
  );

  void _saveEndedLoadingTroughBoxDetails() {
    Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
        listen: false)
        .addEndedLoadingTroughBoxItem(_endedLoadingTroughBox);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final token = auth.token;
//
//    final troughLoading = Provider.of<WitheringLoadingUnloadingRollingProvider>(
//        context,
//        listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trough Loading View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.of(context).pushNamed('MainMenu');
//               Navigator.popUntil(context, ModalRoute.withName('MainMenu'));
            },
            disabledColor: Colors.white,
            iconSize: 35.0,
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
            listen: false)
            .fetchAndSetTroughLoadingItem(token),
        builder: (ctx, snapshot) => snapshot.connectionState ==
            ConnectionState.waiting
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Consumer<WitheringLoadingUnloadingRollingProvider>(
          child: Center(
            child: const Text(
                'Got no Trough Loading items found yet, start adding some!'),
          ),
          builder: (ctx, WitheringLoadingUnloadingRollingProvider, ch) =>
          WitheringLoadingUnloadingRollingProvider
              .troughLoadingItems.length <=
              0
              ? ch
              : ListView.builder(
            itemCount: WitheringLoadingUnloadingRollingProvider
                .troughLoadingItems.length,
            itemBuilder: (ctx, i) => TroughLoadingItem(
              id: WitheringLoadingUnloadingRollingProvider
                  .troughLoadingItems[i].id,
              troughNumber:
              WitheringLoadingUnloadingRollingProvider
                  .troughLoadingItems[i].troughNumber,
              boxNumber:
              WitheringLoadingUnloadingRollingProvider
                  .troughLoadingItems[i].boxNumber,
              gradeGL: WitheringLoadingUnloadingRollingProvider
                  .troughLoadingItems[i].gradeOfGL,
              recentWeight:
              WitheringLoadingUnloadingRollingProvider
                  .troughLoadingItems[i].netWeight,
//                              netWeight: 10.0,
              netWeight: WitheringLoadingUnloadingRollingProvider
                  .totalTroughBoxWeight(
                  WitheringLoadingUnloadingRollingProvider
                      .troughLoadingItems[i].troughNumber,
                  WitheringLoadingUnloadingRollingProvider
                      .troughLoadingItems[i].boxNumber,
                  DateTime
                      .now()), //A function should be written to todays whole weight of trough number box number
            ),
          ),
        ),
      ),

//      Column(
//        children: [
//          Expanded(
//              child: ListView.builder(
//            itemCount: troughLoading.troughLoadingItems.length,
//            itemBuilder: (ctx, i) => TroughLoadingItem(
//              id: troughLoading.troughLoadingItems[i].id,
//              troughNumber: troughLoading.troughLoadingItems[i].troughNumber,
//              boxNumber: troughLoading.troughLoadingItems[i].boxNumber,
//              gradeGL: troughLoading.troughLoadingItems[i].gradeOfGL,
//              recentWeight: troughLoading.troughLoadingItems[i].netWeight,
//              netWeight: troughLoading.totalTroughBoxWeight(
//                  troughLoading.troughLoadingItems[i].troughNumber,
//                  troughLoading.troughLoadingItems[i].boxNumber,
//                  DateTime
//                      .now()), //A function should be written to todays whole weight of trough number box number
//            ),
//          ))
//        ],
//      ),
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
                  Navigator.of(context).pushNamed('RemeasuringInputCollectionScreen');
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
              'End Box',
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
                          const Text('Do you want to end loading the box?'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Yes'),
                        onPressed: () {
                          // Should add the latest trough number and the box number to a new list endedTroughBoxItems with date
                          _endedLoadingTroughBox = EndedLoadingTroughBox(
                            id: DateTime.now().toString(),
                            troughNumber: Provider.of<
                                WitheringLoadingUnloadingRollingProvider>(
                                context,
                                listen: false)
                                .latestAddedLoadingTroughNumber(),
                            boxNumber: Provider.of<
                                WitheringLoadingUnloadingRollingProvider>(
                                context,
                                listen: false)
                                .latestAddedLoadingBoxNumber(),
                            date: DateTime.now(),
                          );

                          _saveEndedLoadingTroughBoxDetails();
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
